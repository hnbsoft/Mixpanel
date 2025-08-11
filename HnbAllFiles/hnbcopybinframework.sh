#!/bin/sh

# How to add the script to your "Framework Project"
# Steps (Open your framework project):
#    1. "Edit Scheme" -> "Archive" -> "Post-actions" -> "+" -> "New Run Script Action"
#    2. Select your framework name in "Provide build settings from" popupbox
#    3. Enter this path in the script textfield: "${PROJECT_DIR}/HnbAllFiles/hnbcopybinframework.sh"
#    4. Check "Shared" after "Manage Schemes" button at the most-bottom of this window

# Configs here
kBaseDirPath="${PROJECT_DIR}/HnbBuildOutput"
kFrameworkName="${PRODUCT_NAME}.framework"
kLogFilePath="$kBaseDirPath/hnbcopyfileslog.log"
kSharedFrameworksDirPath="$kBaseDirPath/BinFrameworks"
kBuiltBinaryFrameworkPath="${SYMROOT}/Release/$kFrameworkName"
kBuiltFrameworkDSYMPath="${SYMROOT}/Release/$kFrameworkName.dSYM"

# copying paths (constructed from above path configs.)
kCopyFromBinaryFrameworkPath="$kBuiltBinaryFrameworkPath"
kCopyToBinaryFrameworkPath="$kSharedFrameworksDirPath/$kFrameworkName"

kCopyFromFrameworkDSYMPath="$kBuiltFrameworkDSYMPath"
kCopyToFrameworkDSYMPath="$kSharedFrameworksDirPath/$kFrameworkName.dSYM"

# Create the log file
echo "[+++++ Copy Framework Log: $kFrameworkName +++++]" > $kLogFilePath

# function: log a string to a file
# Usage: mylog "Hello"
mylog()
{
    # The following command appends another line of text to the file.
    echo "[$1]" >> $kLogFilePath
}

# Do works here
# show the log file's path
mylog "log file at:$kLogFilePath"

# Copy framework here
# 1. Reset folders
CommandRemoveBuildOutputFolder="rm -rf \"$kSharedFrameworksDirPath\""
CommandMakeBuiltFrameworksFolder="mkdir -p \"$kSharedFrameworksDirPath\""

mylog "Remove Old Bin Frameworks Folder command is:$CommandRemoveBuildOutputFolder"
mylog "Make Built Bin Frameworks Folder command is:$CommandMakeBuiltFrameworksFolder"

mylog "Executing Reset Bin Frameworks Folder command NOW..."
eval $CommandRemoveBuildOutputFolder
eval $CommandMakeBuiltFrameworksFolder


# 2. copy the new built framework 
CommandCopyNewFramework="cp -R -H \"$kCopyFromBinaryFrameworkPath\" \"$kCopyToBinaryFrameworkPath\""
CommandCopyNewDSYM="cp -R \"$kCopyFromFrameworkDSYMPath\" \"$kCopyToFrameworkDSYMPath\""

mylog "Copy new framework command is:$CommandCopyNewFramework"
mylog "Copy new framework dSYM command is:$CommandCopyNewDSYM"

if [ "${CONFIGURATION}" = "Release" ]; then
     mylog "Executing Copy New Framework and dSYM Commands NOW (Release mode)"
     eval $CommandCopyNewFramework
     eval $CommandCopyNewDSYM
else
    mylog "*** WARNING ***: Your building is NOT in a Release mode, so we dont copy any framework"
fi

mylog "----- Copy Frameworks Logs -----"
