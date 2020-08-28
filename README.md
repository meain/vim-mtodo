<h1 align="center">mtodo</h1>
<p align="center">A very a simple todo thingy</p>
<p align="center">
  <img src="https://i.imgur.com/eNX2ucF.png">
</p>

## Usage

_Just `set ft=mtodo` to use it_

### 3 kind + heading

- `#` Heading
- `-` normal todo
- `x` done todo
- `*` important todo

_Todo items can be nested_

### 3 mappings

- `gd` mark done
- `gu` mark undone
- `gs` mark important (star)


## Customizing

### Colors

```
highlight default link MTODOTitle SpecialKey
highlight default link MTODOPending Normal
highlight default link MTODODone Comment
highlight default link MTODOImportant Question
```


### Disable keybindings

```
let g:vim_mtodo_disable_keybindings=1
```
