/*
NodeJS deployment file - required to have Node installed on your machine!

@link: https://nodejs.org/en
*/

import { createRequire } from "module";
const require = createRequire(import.meta.url);
const { exec } = require("child_process");

const AMIData = require("../output.json");
const envData = require("../variables.json");
const amiRegex = /ami-[\w-]+/;

const cloudProvider = process.argv[2];
if (cloudProvider === undefined)
  throw new Error('Expecting process.argv[2] to indicate the cloud provider. Got: None.');

console.log(`Executing AMI auto-deployment on the ${cloudProvider} cloud`);

const AMIID = AMIData.builds[AMIData.builds.length - 1].artifact_id.match(amiRegex)[0]

// Execute a child command through JS
exec(`aws ec2 run-instances --image-id ${AMIID} --count 1 --instance-type t2.micro --key-name ${envData.key_name} --security-group-ids ${envData.security_group_id} --region ${envData.region}`, (err, stdout, stderr) => {
  if (err) {
    // Node couldn't execute the command
    console.log("There was an error in the aws subcommand!")
    console.log(err);
    return;
  }

  // The *entire* stdout and stderr (buffered)
  console.log(`stdout: ${stdout}`);
  if (stderr !== undefined && stderr !== "")
    console.log(`stderr: ${stderr}`);
});