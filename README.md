# redka

The main purpose of this project is to re-implement Redis server using Haskell and STM with BSD license.
Though, the project is going to be used in other my projects. And they do not require persistence at the moment.

## Execute

* Run `stack exec -- redka-exe` to see "We're inside the application!"
* With `stack exec -- redka-exe --verbose` you will see the same message, with more logging.

## Run tests

`stack test`

## Benchmark

Right now Redka is on par with Redis without persistence, though using Scanner interface may give a significant boost in parsing mode.
Though had it not been for Attoparsec, there would be no possibility to implement it in a matter of a day.
