#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: Folder name not provided."
  echo "Usage: $0 folder_name"
  exit 1
fi

FOLDER_NAME="$1"

cd lib/features || exit

# Create the root folder
mkdir "$FOLDER_NAME"

# Data
mkdir -p "$FOLDER_NAME/data"
mkdir -p "$FOLDER_NAME/data/datasource"
mkdir -p "$FOLDER_NAME/data/dto"
mkdir -p "$FOLDER_NAME/data/repositories"

# Domain
mkdir -p "$FOLDER_NAME/domain"
mkdir -p "$FOLDER_NAME/domain/entities"
mkdir -p "$FOLDER_NAME/domain/repositories"

# Presentation
mkdir -p "$FOLDER_NAME/presentation"
mkdir -p "$FOLDER_NAME/presentation/providers"
mkdir -p "$FOLDER_NAME/presentation/pages"
mkdir -p "$FOLDER_NAME/presentation/widgets"

echo "Clean Architecture's folders tree generated successfully."
