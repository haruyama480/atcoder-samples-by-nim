# atcoder-samples-by-nim

## installation

- python3
- fabric
- VSCode
- ghq

```
pip install lxml requests fabric beautifulsoup4 matplotlib cached_property jinja2
```

```
find . -type f -name "nim.cfg" -print0 | xargs -0 sed -i '' -e "s/kazusaku/${USER}/"
ghq get https://github.com/zer0-star/Nim-ACL
ln -s ~/ghq/github.com/zer0-star/Nim-ACL/src nim/nim-acl-alias
```

## usage

```
fab open --cid abc --cnum 170

>>> # help
>>> h
>>> # to submit
>>> act.submit_nim('a')
```
