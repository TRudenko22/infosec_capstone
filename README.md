# Cloud Infrastructure Deployment for CTF Platform via Linode
**Information Security Capstone project**
By: [Tim Rudenko](github.com/TRudenko22) & [Michael Buckley](github.com/piCounter)
Completed for STCC <stcc.edu> CIT-252 2023SP

## What is ___?
___ is an easy to use interface to spin up and tear down Linode Cloud Infrastructure and automatically deploy your own custom CTF Framework.

## Features

## Install
This guide outlines the steps required to deply a Capture the Flag (CTF) platform on Linode cloud infrastructure.

### Prerequisites
- Knowledge of how to use a terminal or command line interface
- Basic knowledge of Linux server administration
- Linode account with access to the Linode Manager Dashboard
- Linode API Token for creating, destroying, and managing instances

### Step 1: Clone this repo
`git clone https://github.com/TRudenko22/infosec_capstone.git`

### Step 2: to add you API key
1. Edit ./infrastructure/ctf_platform/variables.tf
2. Uncomment `default = "null"` 
3. Replace `null` with your access token

### Step 3: Move to scripts directory
`cd` to infosec_capstone/infrastructure/scripts/

### Step 4: execute run.sh
`./run.sh`

## Demo

## Credits
- Concept: Collaberative effort as the idea evolved over time
- Terraform: [Tim Rudenko](github.com/TRudenko22)
- Bash: [Michael Buckley](github.com/piCounter)
- Cloud Provider: [Linode/Akamai](linode.com)
- CTF Framework: [CTFd](github.com/CTFd/CTFd)
