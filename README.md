# Cloud Infrastructure Deployment for CTF Platform via Linode
**Information Security Capstone project**
- By: [Tim Rudenko](github.com/TRudenko22) & [Michael Buckley](github.com/piCounter)
- Completed for STCC <stcc.edu> CIT-252 2023SP

## What is ___?
___ is an easy to use interface to spin up and tear down Linode Cloud Infrastructure and automatically deploy your own custom CTF Framework.

## Features
⚡**One-Command Operation**: Your time is precious, and we respect that. That's why we've forged a system that can accomplish your mission in just one command. No more endless scripts, no more trial and error, no more excessive time waste. With a single line of code, you can summon the powers of the cloud and host your CTFd website. Just like a superhero with a catchphrase, we have ours: `./run.sh`.

🔥**Automated Linode Deployment**: The Linode Cloud Server, your faithful sidekick in this digital universe, is just a command away. It's like having a loyal robot butler who's always ready to serve. Our system swiftly and efficiently spins up a Linode server tailored to your needs. It's automation at its best. It's the future, today.

💫**CTFd Hosting**: You're on a quest to educate, challenge, and inspire cybersecurity enthusiasts. We've got your back with seamless CTFd website hosting. Your challenges, your scoreboard, your rules. All hosted in a place accessible from anywhere in the world. Be the lighthouse in the dark sea of cybersecurity.

🌐**Docker Containerization**: A superhero needs a suit, and your CTFd website needs a Docker container. Not just any container, but a secure, isolated, and efficient one. Our system wraps your CTFd website in a Docker container, providing the robustness it needs to withstand the cyber storms.

⚙️**Easy Updates**: Just as superheroes upgrade their gadgets, you can update your CTFd website effortlessly. Our system is designed to handle updates smoothly, ensuring your CTFd website always stays ahead of the curve, always prepared to meet new challenges.

🛡️**Security**: In this cyber world, we understand that security isn't an option; it's a necessity. That's why our system is built with security at its core. With our vigilant system guarding your CTFd website, rest assured, your challenges and data are safe and secure.

🚀**Quick Setup**: Time waits for no one, and we won't let it wait for you. Our system ensures quick setup, so you can focus on what matters most: creating, challenging, and inspiring.

✨**User-Friendly**: Even though it's powered by complex tech, using our system is as easy as flicking a switch. You don't need to be a coding wizard to use it. If you can type, you can command this system.

💡**Exceptional Support**: Even superheroes sometimes need a hand. That's why we're here, ready to assist whenever you need us. Our support team, your league of extraordinary helpers, is always eager to help you, guide you, and ensure your digital journey is smooth and successful.

In this world where cyber threats lurk in every corner, we're on a mission to arm you with the best. With our system by your side, you're not just a cybersecurity enthusiast; you're a cyber superhero. So, put on your cape, type the command, and let's make the cyber world a safer place, one CTFd challenge at a time.

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
[![youtube](https://www.youtube-nocookie.com/embed/sDDEnUs3PG4)](https://youtu.be/sDDEnUs3PG4)

## Credits
- Concept: Collaberative effort as the idea evolved over time
- Terraform: [Tim Rudenko](github.com/TRudenko22)
- Bash: [Michael Buckley](github.com/piCounter)
- Slides: [Tim Rudenko](github.com/TRudenko22)
- Demo Video: [Michael Buckley](github.com/piCounter)
- Cloud Provider: [Linode/Akamai](linode.com)
- CTF Framework: [CTFd](github.com/CTFd/CTFd)
- Features Drama: [ChatGPT](chat.openai.com/?model=gpt-4)
