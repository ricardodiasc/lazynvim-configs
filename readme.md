# Ricardo Dias Lazy Nvim configs

This is my personal Neovim config with some of the languages that I use. 
Java still to be completed.

WIP.

## Workarrounds

### Angular LSP not starting up

If the Angular LSP is not starting from a specific project, check the typescript and angular version. 
The Mason installation always pulls the lattest version and sometimes the project will not be compatible with newer Angular/Typescript.

* Solution

Go to the package folder from Mason and change the package.json with the project versions of Typescript and Angular:

```shell
cd $USER_HOME/.local/share/nvim/mason/packages/angular-language-server/
nvim package.json

npm install
```

### Java test package

vscode-java-test changed the way the package is built and Mason installation is deprecated.

[Test methods not working on jdtls](https://github.com/mfussenegger/nvim-jdtls/issues/565)

So to fix the tests, follow the instructions from user cladeira:


Go to Mason's java-test package folder ~/[MASON_PATH]/packages/java-test. Here you will find a handful of files and the extension folder that contains the jar files.
Clone vscode-java-test repo
Go inside the cloned repo and run:
```shell
npm i
npm run build-plugin

```
Go up and make a copy of the original extension folder mv extension extension-bkp
Create a symbolic link to the cloned repo:

```shell
ln -s ./vscode-java-test extension

```
That's it, relaunch nvim and you are good to go 😄

Note: If you inspect the manson-receipt.json you fill find explicit references to the jar files that point to the previous versions. It should be ok if you don't modify those because the plugin that uses them utilises a glob expression.

