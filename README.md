# EL7 DISA STIG InSpec Profile derived from the [NSA SIMP Project](https://github.com/simp/inspec-profile-disa_stig-el7)

This [InSpec](https://github.com/chef/inspec) profile is being developed and
maintained as part of the SIMP project.

# Testing

This repository has been tested using the [KitchenCI](http://kitchen.ci) framework and 
[Kitchen-EC2](https://github.com/test-kitchen/kitchen-ec2) and/or
the [Terraform](http://terraform.io) framework. It has been optimized for the use with AWS Redhat images
that have been launched using the GenericNode terrafor code, then hardened using the Chef
 baseline cookbook.

# Testing with Kitchen

## Dependencies

* Ruby 2.3.0 or later
* Kitchen-EC2
* AWS Account to launch nodes into

## Validating your box

1. Clone the repo via `git clone <REPO_LOCATION>`
2. cd to `inspec-profile-disa_stig-el7`
3. On the terminal: 

* `export SSH_KEY=/path/to/ssh/pemfile`

* `export TARGET_IP=IP_OF_TARGET_HOST`

4. Run Scan: 
* All controls against machine:

* `inspec exec . --input-file=./attributes.yml --reporter=cli -t ssh://ec2-user@${TARGET_IP} --sudo -i $SSH_KEY`

* A single Control against machine:

* `inspec exec ./controls/V-#####.rb --input-file=./attributes.yml --reporter=cli -t ssh://ec2-user@${TARGET_IP} --sudo -i $SSH_KEY`

* Example: `inspec exec ./controls/V-77823.rb --input-file=./attributes.yml --reporter=cli -t ssh://ec2-user@${TARGET_IP} --sudo -i $SSH_KEY` 

* A list of controls against machine:

* `inspec exec . --input-file=./attributes.yml --controls=V-##### V-##### -t ssh://ec2-user@${IP} --sudo -i $SSH_KEY` 

* Example: `inspec exec . --controls=V-77823 V-73171 --input-file=./attributes.yml --reporter=cli -t ssh://ec2-user@${TARGET_IP} --sudo -i $SSH_KEY`

## Saving your output

### Regular Text File
  * To save your output just use `> output.txt`

### Save as HTML

In the `tools` directory there are a few useful scripts for getting a little
better output for general display and demo, to use them see the `README.md`
file in the `tools` directory or as an example:

  * `kitchen converge (machine name) | ./tools/ansi2html.sh --bg=dark > kitchen-run.html`
  * `inspec exec . -i $SSH_KEY -t ssh://ec2-user@${IP} | ./tools/ansi2html.sh --bg=dark > inspec-validation-run.html`
