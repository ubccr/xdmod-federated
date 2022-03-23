#!/usr/bin/env expect
# Expect script that run s xdmod-setup to configure a freshly installed
# XDMoD instance. This script will fail if run against an already installed
# XDMoD.

# Load helper functions from helper-functions.tcl
source [file join [file dirname [info script]] /root/xdmod/tests/ci/scripts/helper-functions.tcl]

proc answerQuestion1 { question response } {
	expect {
		timeout { send_user "\nFailed to get prompt\n"; exit 1 }
		-re "\n$question: \\\[.*\\\] "
	}
	send $response\n
}
#-------------------------------------------------------------------------------
# Configuration settings for the XDMoD resources

set federatedinstances [list]

# Federation Instances
lappend federatedinstances [list test1.example.com xdmod1@example.com]
lappend federatedinstances [list test2.example.com xdmod2@example.com]
lappend federatedinstances [list test3.example.com xdmod3@example.com]
lappend federatedinstances [list test4.example.com xdmod4@example.com]
# -------------

set federatedresources [list]
# HPC Resources
lappend federatedresources [list AMNH-mendel AMNH-mendel hpc 26 1344]
lappend federatedresources [list TACC-frontera TACC-frontera hpc 8008 448448]
lappend federatedresources [list CCR-ub-hpc CCR-ub-hpc hpc 779 11386]
lappend federatedresources [list CCR-lakeeffect UB-lakeeffect cloud 1 1]
lappend federatedresources [list Cornell-redcloud Cornell-redcloud cloud 1 1]
# -------------

#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# main body - note there are some hardcoded addresses, usernames and passwords here
# they should typically not be changed as they need to match up with the
# settings in the docker container

set timeout 60
spawn "xdmod-setup"

selectMenuOption 9
selectMenuOption 1
provideInput {Is this a federation `hub` or `instance`?} hub
confirmFileWrite yes
enterToContinue

foreach instance $federatedinstances {
	selectMenuOption 3
	provideInput {What is the url of the federated instance:} [lindex $instance 0]
	provideInput {Who is the contact for this instance:} [lindex $instance 1]
  enterToContinue
}

selectMenuOption r

# Enter config settings for each resource
selectMenuOption 4
foreach resource $federatedresources {
	selectMenuOption 1
	provideInput {Resource Name:} [lindex $resource 0]
	provideInput {Formal Name:} [lindex $resource 1]
	provideInput {Resource Type*} [lindex $resource 2]
	provideInput {How many nodes does this resource have?} [lindex $resource 3]
	provideInput {How many total processors (cpu cores) does this resource have?} [lindex $resource 4]
}

selectMenuOption s
confirmFileWrite yes
enterToContinue
confirmFileWrite yes
enterToContinue

selectMenuOption q

lassign [wait] pid spawnid os_error_flag value
exit $value
