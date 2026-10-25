# Mini Project: Gitflow Simulation

A minimal hands-on project for Week 7 Git fundamentals and intermediate Git.

## Workflow
`feature branch -> Pull Request -> merge -> release -> hotfix -> merge back to main`

## Requirements
- Git
- Python 3 (only used for a tiny test script)

## 1. Initialize the repository
```bash
git init
git add .
git commit -m "chore: initial commit"
git branch -M main
git checkout -b develop
```

## 2. Feature branch and Pull Request
```bash
git checkout -b feature/greeting
```
Edit `app.py`, then:
```bash
git add app.py
git commit -m "feat: add greeting"
```
Push the branch and open a Pull Request on GitHub:
```bash
git push -u origin feature/greeting
```
Merge the PR into `develop` using GitHub, or locally:
```bash
git checkout develop
git merge --no-ff feature/greeting
```

## 3. Release
```bash
git checkout -b release/v1.0.0 develop
python test_app.py
git checkout main
git merge --no-ff release/v1.0.0
git tag -a v1.0.0 -m "Release v1.0.0"
git checkout develop
git merge --no-ff release/v1.0.0
```

## 4. Hotfix from production
```bash
git checkout main
git checkout -b hotfix/greeting-fix
```
Make a small fix in `app.py`, test and commit:
```bash
python test_app.py
git add app.py
git commit -m "fix: correct greeting"
git checkout main
git merge --no-ff hotfix/greeting-fix
git tag -a v1.0.1 -m "Hotfix v1.0.1"
git checkout develop
git merge --no-ff hotfix/greeting-fix
```

## 5. Week 7 practice commands

### Stash
```bash
git stash
git stash list
git stash apply
git stash pop
```

### Merge conflict
Edit the same line differently on two branches, commit both versions, then merge.
Resolve conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`), then:
```bash
git add app.py
git commit
```

### Rebase vs merge
```bash
git checkout feature/greeting
git rebase develop
```
Use rebase to replay commits on a new base; use merge to preserve branch history.

### Interactive rebase
```bash
git rebase -i HEAD~2
```
In the editor, try `squash`, `fixup`, or reordering commits. Only rewrite commits that have not been shared unless your team agrees.

### Cherry-pick
```bash
git cherry-pick <commit-hash>
```

### Pre-commit hook
Enable the included hook:
```bash
git config core.hooksPath .githooks
```
It runs the tiny test script before a commit. If Python is not available as `python`, adjust the hook to use `python3`.

## Useful inspection commands
```bash
git status
git log --oneline --graph --decorate --all
git branch -a
git tag
```

This repository is a learning simulation. Create the branches and commits yourself so you can explain each step in an assessment.
