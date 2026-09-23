# E190BO — your project repo

This is your working repo for Labs 5, 6, and 7 and for the final project.

## Start here

1. Click **Use this template → Create a new repository**.
   - **Owner: your own account**, not a course organization. This is what keeps
     your Codespaces hours free.
   - **Visibility: Private.**
   - Do *not* use the Fork button. It gives you a public repo you cannot make
     private.
2. In your new repo: **Code → Codespaces → Create codespace on main**.
3. Wait for it to build. First time takes a few minutes; after that it resumes
   in seconds.
4. When the terminal prints the ready banner, run:

   ```bash
   bash demos/check_tools.sh     # every tool, with a ✅ or ❌
   python demos/hello_web.py     # then open port 8080 from the PORTS tab
   ```

   More one-command checks (Docker, Postgres, MCP, notebooks) are in
   [`demos/`](demos/README.md).

That is the whole setup. There is nothing to install on your laptop.

**Do this before class on 9/30, not during it.** A cold build in the first ten
minutes of class is ten minutes you do not get back.

## Why a codespace

Everyone in this class gets the same Linux machine, with the same Python, the
same tools, and the same versions. When you hit an error, it is an error your
classmates and your instructors can reproduce — which is worth more to you than
anything you would gain from configuring it yourself.

It also means you can work from any computer, including a borrowed one.

## If you would rather work locally

Same environment, same file. Install [VS Code](https://code.visualstudio.com/),
the **Dev Containers** extension, and a container runtime (Docker Desktop is free
for students; Podman Desktop, Rancher Desktop and OrbStack also work). Then
**Dev Containers: Reopen in Container**.

You will need roughly 10 GB free. If you do not have it, use the codespace —
that is what it is for, and nobody is grading you on where you typed.

## Watch your hours

GitHub Education gives you 180 core-hours of Codespaces per month. On the 2-core
machine this template uses, that is about 90 hours of actual work — plenty, but
not infinite.

Codespaces stop themselves after 30 minutes idle. To stop one now:

```bash
gh codespace stop
```

## Running things

```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000   # the API
python -m http.server 8080 --directory web             # the frontend
docker compose up -d                                   # Postgres (class 12)
```

VS Code pops up a **Ports** notification with a forwardable URL. That URL is
real and works on your phone — try it.

**Always bind `0.0.0.0`, never `127.0.0.1`.** In a container, `127.0.0.1` means
"reachable only from inside this container," so the port forward finds nothing
and you get a blank page with no error. We will explain properly on 10/12; for
now, just do it.

## Layout

```
.devcontainer/      the environment definition — you should not need to touch it
requirements.txt    Python packages
docker-compose.yml  Postgres, for class 12
.env.example        which environment variables exist (never real secrets)
demos/              one-command checks that each tool works
```

## Getting help

Zulip first — if you are stuck on setup, someone else is too.
