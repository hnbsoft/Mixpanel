#!/bin/sh

# Exit on errors
set -e

# Use of unset variable is an error
set -u

# (POSIX-undefined) If any part of a pipeline of commands fails, the whole pipeline fails
# set -o pipefail

# Configs
haSchemeName="Mixpanel_macOS"
haScriptInDirPath=$(dirname "$0")
haBuildOutputDirPath="${haScriptInDirPath}/../HnbBuildOutput"
haXcodeBuildScript="/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild"

# Make sure xcodebuild command is existed.
if [ ! -f "${haXcodeBuildScript}" ] ; then
    echo "***Error***: No Xcode build script found at: ${haXcodeBuildScript}."
    exit 1
fi

# Reset Hnb Build Output folder
if [ -d "${haBuildOutputDirPath}" ] ; then
    rm -rf "${haBuildOutputDirPath}"
fi

# You MUST make an empty build output directory
haCommandMakeBuildOutputFolder="mkdir -p \"$haBuildOutputDirPath\""
eval $haCommandMakeBuildOutputFolder


# Execute flow is: first clean the proejct, and then execute the archive command.
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "++++++++++++++++++++++++++++++ Start building Hnb-Mixpanel framework +++++++++++++++++++++++++++++++"
echo ""


# Change current directory to the project root dir path.
haProjectRootDirPath="${haScriptInDirPath}/.."
eval "cd \"${haProjectRootDirPath}\""

# Do works.
# 1. Clean it
echo "Current directory is:$(pwd)"
echo "Cleaning Scheme <${haSchemeName}> ..."
"${haXcodeBuildScript}" -quiet -scheme "${haSchemeName}" -destination "generic/platform=macOS" clean

# 2. Archive it
echo "Archiving Scheme <${haSchemeName}> ..."
"${haXcodeBuildScript}" -quiet -scheme "${haSchemeName}" -destination "generic/platform=macOS" archive


echo ""
echo "------------------------------- End of build Hnb-Mixpanel framework --------------------------------"
echo "----------------------------------------------------------------------------------------------------"
echo ""
