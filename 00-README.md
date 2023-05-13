# Compare `mamba` CLI to `conda` with `conda-libmamba-solver`

```bash
build.sh install-conda
build.sh install-mamba-cli
build.sh install-mamba-solver 23.3.1-0

n=mamba-solver; time docker run --name $n $n
# real	6m33.626s
# user	0m0.068s
# sys	0m0.041s

n=install-mamba; time docker run --name $n $n
# real	6m18.406s
# user	0m0.049s
# sys	0m0.024s
```
