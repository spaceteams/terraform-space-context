package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

type Label struct {
	Enabled            bool              `json:"enabled"`
	Name               interface{}       `json:"name"`
	Namespace          interface{}       `json:"namespace"`
	Environment        interface{}       `json:"environment"`
	Stage              interface{}       `json:"stage"`
	Tags               map[string]string `json:"tags"`
	Suffix             []string          `json:"suffix"`
	PermissionBoundary interface{}       `json:"iam_permission_boundary"`
}

// Test the Terraform module in examples/complete using Terratest.
func TestModule(t *testing.T) {

	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "./src",
		Upgrade:      true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Ensure the module works with just the name
	context1 := terraform.OutputMap(t, terraformOptions, "context1")
	context1Tags := terraform.OutputMap(t, terraformOptions, "context1_tags")

	assert.Equal(t, "somelabelname", context1["label"])
	assert.Equal(t, "somelabelname", context1Tags["Name"])
	assert.Equal(t, "somelabelname", context1Tags["spaceteams/full-label"])

	// Ensure it works with a full set of values
	context2 := terraform.OutputMap(t, terraformOptions, "context2")
	context2Tags := terraform.OutputMap(t, terraformOptions, "context2_tags")

	assert.Equal(t, "thecompany-theproject-prod-label2name", context2["label"])
	assert.Equal(t, "thecompany", context2["namespace"])
	assert.Equal(t, "theproject", context2["environment"])
	assert.Equal(t, "prod", context2["stage"])

	assert.Equal(t, "label2name", context2Tags["Name"])
	assert.Equal(t, "thecompany-theproject-prod-label2name", context2Tags["spaceteams/full-label"])
	assert.Equal(t, "thecompany", context2Tags["spaceteams/namespace"])
	assert.Equal(t, "theproject", context2Tags["spaceteams/environment"])
	assert.Equal(t, "prod", context2Tags["spaceteams/stage"])
	assert.Equal(t, "Peter", context2Tags["owner"])

	// Ensure it works with an inheritance from a parent
	context3 := terraform.OutputMap(t, terraformOptions, "context3")
	context3Tags := terraform.OutputMap(t, terraformOptions, "context3_tags")

	assert.Equal(t, "thecompany-theproject-prod-label3name", context3["label"])
	assert.Equal(t, "thecompany", context3["namespace"])
	assert.Equal(t, "theproject", context3["environment"])
	assert.Equal(t, "prod", context3["stage"])

	assert.Equal(t, "label3name", context3Tags["Name"])
	assert.Equal(t, "thecompany-theproject-prod-label3name", context3Tags["spaceteams/full-label"])
	assert.Equal(t, "thecompany", context3Tags["spaceteams/namespace"])
	assert.Equal(t, "theproject", context3Tags["spaceteams/environment"])
	assert.Equal(t, "prod", context3Tags["spaceteams/stage"])
	assert.Equal(t, "Peter", context3Tags["owner"])
	assert.Equal(t, "true", context3Tags["value"])

	// Ensure the module shortens labels when necessary
	context4 := terraform.OutputMap(t, terraformOptions, "context4")
	context4Tags := terraform.OutputMap(t, terraformOptions, "context4_tags")

	assert.Equal(t, "label4namex-d88616ea", context4["label"])
	assert.Equal(t, 20, len(context4["label"]))
	assert.Equal(t, "thecompany", context4["namespace"])
	assert.Equal(t, "theproject", context4["environment"])
	assert.Equal(t, "prod", context4["stage"])

	assert.Equal(t, "label4namexx", context4Tags["Name"])
	assert.Equal(t, "thecompany-theproject-prod-label4namexx", context4Tags["spaceteams/full-label"])
	assert.Equal(t, "thecompany", context4Tags["spaceteams/namespace"])
	assert.Equal(t, "theproject", context4Tags["spaceteams/environment"])
	assert.Equal(t, "prod", context4Tags["spaceteams/stage"])
	assert.Equal(t, "Peter", context4Tags["owner"])

	// Ensure the module stacks suffixes
	context5 := terraform.OutputMap(t, terraformOptions, "context5")
	context51 := terraform.OutputMap(t, terraformOptions, "context51")

	assert.Equal(t, "somelabelname-suffix1", context5["label"])
	assert.Equal(t, "somelabelname-suffix1-suffix2", context51["label"])
	assert.Equal(t, "boundary1", context5["iam_permission_boundary"])
	assert.Equal(t, "boundary2", context51["iam_permission_boundary"])
}
