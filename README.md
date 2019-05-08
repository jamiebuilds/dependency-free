# dependency-free

> An experiment to unify/speed up CI/local development via small Docker containers

- Reproducible build steps on every machine (local or CI).
- Enables faster parallelized builds via focused dependencies.
- Easier setup for new developers.

## Motivation

Node packages tend to have thousands if not tens of thousands of dependencies
which are all listed in a single `package.json`. However, most of the time you
only need a subset of these dependencies, like if you just want to run the
linter, you don't need all of the dependencies for the test runner. This
overhead impacts both local development, and CI times.

Say we have a CI build that wants to do these five things:

- format
- lint
- typecheck
- test
- build

To improve performance, we could run each of these in parallel CI jobs. However,
if we're just running a simple `npm install` to get all the dependencies in
`package.json`, we end up wasting a whole bunch of time installing dependencies
inside of a job that we're never going to use in the job.

Additionally, what if we want to have complex build scripts that run our tests
or build, and those scripts have native build tools (that can't be installed by
`npm install`)?

Now we need to have a setup process for both local development and in CI. And
most of the time those are different operating systems, so the setup process
needs to exist in multiple forms. Then you're dealing with individual
developer's local setups.

## Experiment

The idea I am experimenting with here is having a setup like this:

```
/package/
    package.json
    package-lock.json
    ...config-files...
    /.build/
        /task-1/
            Dockerfile
            package.json
            package-lock.json
        /task-2/
            Dockerfile
            package.json
            package-lock.json
```

Here I am taking the dependencies/scripts from a single `package.json` and
splitting them up into individual "tasks". These tasks contain a `Dockerfile`
and a `package.json` (and matching `package-lock.json`) with only the
dependencies they need to run.

I'm doing this so that:

- Tasks only install the dependencies they actually need.
- Tasks work exactly the same way on every machine.

In order to run the tasks I have a simple bash script `.build/run`:

```bash
#!/bin/bash
set -eufo pipefail

REPO=$(basename "$PWD")
ARGS=${*:2}
NAME="$REPO-$1"

docker build -q -f "./.build/$1/Dockerfile" -t "$NAME" . > /dev/null
docker run --name "$NAME" --rm -it -p 8000:8000 -p 8080:8080 -v "$PWD:/workdir" "$NAME" $ARGS
```

To run a task, I simply run:

```sh
.build/run task-name
```

## Learnings

This experiment has led to much faster builds in CI. A lot less time is wasted
running `npm install`, and because it is faster to install dependencies you can
parallelize longer processes like unit tests across more jobs without running
into diminishing returns as quickly.

I played around with the idea of having all the config files and dependencies
inside the tasks that used them, and completely eliminate them outside of
`.build`. However, this doesn't mesh well with how the JavaScript ecosystem
works. There are too many times where you want configs/dependencies for
multiple tools across multiple tasks (i.e. If you are using TypeScript, you
need TypeScript's dependencies for pretty much every task).

Lots of tools (i.e. TypeScript/ESLint) that run as part of code editors force
you to install them and all their dependencies in the root `package.json`
outside of containers. This leads to some overhead for other tasks, but it
still a dramatic improvement and can be somewhat fixed by splitting
`dependencies/devDependencies` and using `npm install --production` in places.
