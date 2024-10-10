What to `brew install` is listed below when not obvious.

ASM
---

```sh
nasm -f macho64 parrot_spam.x86_64.macos.asm
gcc parrot_spam.x86_64.macos.o -o parrot_spam
./parrot_spam :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Awk
---

```sh
awk -f parrot_spam.awk :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Bash
----

```sh
bash parrot_spam.sh :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

C
---

```sh
gcc parrot_spam.c -o parrot_spam
./parrot_spam :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

C++
---

```sh
g++ parrot_spam.cpp -o parrot_spam
./parrot_spam :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

C#
--

```sh
brew install mono
mcs ParrotSpam.cs
mono ParrotSpam.exe :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Clojure
--

```sh
brew install clojure
./parrot-spam.clj :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

D
---

```sh
dmd parrot_spam.d
./parrot_spam :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Elixir
------

```sh
brew install elixir
elixir parrot_spam.exs :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

F#
--

```sh
brew install mono
fsharpc ParrotSpam.fs
mono ParrotSpam.exe :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Go
---

```sh
go build parrot_spam.go
./parrot_spam :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:

go build parrot_spam_goroutine.go
./parrot_spam_goroutine :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Groovy
------

```sh
groovy parrot_spam.groovy :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Haskell
-------
```sh
# Install GHCup.  Then,
stack runghc ParrotSpam.hs :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Haskell (Parrots as a Service)
------------------------------

```sh
# Install Nix by piping the internet into bash.  Good stuff.  Then,
cd PSaaS.hs
nix-shell -p 'runghc src/Main.hs'

# In another terminal,
curl -X GET -H 'Content-Type: application/json' --data '["parrotwave1","parrotwave2","parrotwave3","parrotwave4","parrotwave5","parrotwave5","parrotwave6","parrotwave7"]' localhost:8080
```

Java
----

```sh
javac ParrotSpam.java
java ParrotSpam :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Javascript
----------

```sh
node parrot_spam.js :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Perl 5
------

```sh
perl parrot_spam.pl :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Perl 6
------

```sh
brew install perl6
perl6 parrot_spam.p6 :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

PHP
---

```sh
php parrot_spam.php :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Python
------

```sh
python parrot_spam.py :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```

Rust
----

```sh
brew install rustup-init
rustup-init

# Normal version
rustc parrot_spam.rs -C opt-level=3

# OsString version to avoid unnecessary UTF-8 conversion
rustc parrot_spam_os_string.rs -C opt-level=3
```

Scala
-----

```sh
./ParrotSpam.scala :parrotwave1: :parrotwave2: :parrotwave3: :parrotwave4: :parrotwave5: :parrotwave6: :parrotwave7:
```
