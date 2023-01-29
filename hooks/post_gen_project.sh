#!/bin/bash

poetry env use {{cookiecutter.python_version}}
counter=0
until poetry update || [[ $counter -gt 2 ]]; do
    ((counter++))
done
poetry run make format

commit_message="Initial project structure based on https://github.com/Barahlush/python_project_starter/tree/master"

mv .hgignore .gitignore
git init .
if [ -n "{{cookiecutter.github_respository_url}}" ]; then
    git remote add origin {{cookiecutter.github_respository_url}}
fi
git add -A .
git commit -m "$commit_message"

make install_hooks
