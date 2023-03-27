## Macbook: Development Environment Quickly

A script for quickly setting up a development environment on the new Macbook. The script installs programming languages, IDEs, GNU software collections, and so on.


## Installation

It's highly recommended to clone this repository and manually run the install script, like this:

```
git clone https://github.com/lk-geimfari/macbook.git
cd macbook && chmod +x install.sh
./install.sh
```

or you can run remote script file with a single command like this:

```bash
bash <(curl https://git.io/JD1xV -sSfL)
```

which is shortened version of:

```bash
bash <(curl https://raw.githubusercontent.com/lk-geimfari/macbook/exec/install.sh -sSf)
```

`exec` is a stable branch which means it can be outdated in comparison with a `master`.
