# Contribution Guildlines

> *tl;tr* For pull request, please do check **Allow edits from maintainers**, and merge from **your new branch** into **my master branch**.

## Fork and Pull Model

If you are going to create a new feature or fix a bug, please follow the "fork and pull" model:

1. Before writing codes, as you know:
  1. Click the nice **fork** button in <https://github.com/Edditoria/numbo>
  2. In Terminal / Command Prompt, `git clone https://github.com/{your.username}/numbo.git`
  3. `git remote add upstream https://github.com/Edditoria/numbo.git` for fetch and merge in future
1. Create a new branch:
  - `git checkout -b hotfix/{fix-a-bug} {master}` to fix a bug
  - Or, `git checkout -b feature/{awesome-feature} {master}` to create awesome features.
1. You will need npm to work with you: `npm install --dev`
1. Work on your codes... (Thanks!!)
1. Before `commit -am`, please run `npm test` to make a basic test.
1. Push to Github `git push origin feature/{awesome-feature}`
1. In Github, go to my [numbo repo](https://github.com/Edditoria/numbo/)
1. Click the nice **Compare & pull request** button
1. :warning: Remember to pull to **master branch**. Make sure:
  - [ ] "base fork: Edditoria/numbo" and "base: master"
  - [ ] "head fork: your.name/numbo" and "compare: awesome-feature"
  - [ ] In the the right sidebar of your pull request, select **Allow edits from maintainers**.
  - [ ] Leave a comment to me. Click "Create pull request".

In general case, I will:

1. create a new branch,
2. evaluate your awesome codes,
3. communicate with you and further edit,
4. commit and merge it back into master branch.

After your pull request is merged, you can safely erase your branch and pull the changes from my repo:

1. `git push origin --delete feature/{awesome-feature}`
2. `git checkout master -f`
3. `git branch -D feature/{awesome-feature}`
4. `git pull --ff upstream master`

## Proposing File Change

Sometimes you may want to fix a typo, or do some small changes that doesn't need a test, you can **propose file change** directly.

> reference: [Editing files in another user's repository - *Github Help*](https://help.github.com/articles/editing-files-in-another-user-s-repository/)

:beer: Thank you so much for your contribution!! :pray:
