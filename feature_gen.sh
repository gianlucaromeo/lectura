#!/bin/bash

createFolderWithGitkeep() {
    local path="$1"
    mkdir -p "$path" && touch "$path/.gitkeep"
}

if [ -z "$1" ]; then
  echo "Error: Folder name not provided."
  echo "Usage: $0 folder_name"
  exit 1
fi

FOLDER_NAME="$1"

cd lib/features || exit

# Create the root folder
createFolderWithGitkeep "$FOLDER_NAME"

# Data
createFolderWithGitkeep "$FOLDER_NAME/data"
createFolderWithGitkeep "$FOLDER_NAME/data/datasources"
createFolderWithGitkeep "$FOLDER_NAME/data/dto"
createFolderWithGitkeep "$FOLDER_NAME/data/exceptions"
createFolderWithGitkeep "$FOLDER_NAME/data/failures"
createFolderWithGitkeep "$FOLDER_NAME/data/repositories"

# Domain
createFolderWithGitkeep "$FOLDER_NAME/domain"
createFolderWithGitkeep "$FOLDER_NAME/domain/entities"
createFolderWithGitkeep "$FOLDER_NAME/domain/repositories"
createFolderWithGitkeep "$FOLDER_NAME/domain/use_cases"

# Presentation
createFolderWithGitkeep "$FOLDER_NAME/presentation"
createFolderWithGitkeep "$FOLDER_NAME/presentation/bloc"
createFolderWithGitkeep "$FOLDER_NAME/presentation/pages"
createFolderWithGitkeep "$FOLDER_NAME/presentation/validators"
createFolderWithGitkeep "$FOLDER_NAME/presentation/widgets"

echo "Clean Architecture's folders tree generated successfully."
