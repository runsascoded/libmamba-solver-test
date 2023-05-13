# Compare `mamba` CLI to `conda` with `conda-libmamba-solver`

```bash
build() {
    n=mamba-$1
    docker rmi $n 2>/dev/null  # allows re-running test, by clearing `env update` layer from docker build cache
    time docker build -f $n.dockerfile -t $n .
}

build cli     # `mamba` CLI
build solver  # `conda` CLI with `conda-libmamba-solver`
```
