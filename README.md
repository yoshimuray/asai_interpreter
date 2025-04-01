# asai_interpreter

http://pllab.is.ocha.ac.jp/interpreter.php

## 進め方

- dune と ppx_inline_test の導入 
  `$ opam install dune ppx_inline_test`
- プロジェクトを作成
  `$ dune init proj asai_interpreter`

  ディレクトリ構成
  ```
  asai_interpreter/
  ├─ bin/
  │  ├─ main.ml
  │  └─ dune
  ├─ lib/
  │  ├─ interpreter.ml
  │  └─ dune
  ├─ dune-project
  └─ [projext_name].opam
  ```
- `lib/` に必要なモジュールを定義していって、とりあえずインラインテストでテスト
  - `lib/dune` の記述例
    ```
    (library
      (name asai_interpreter)
      (inline_tests)
      (preprocess (pps ppx_inline_test)))
    ```
  - `$ dune test` でテストを実行
  - テストの例
    ```
    let%test _ = 
      eval (Plus (Number 3, Times (Number 4, Minus (Number 5, Number 2))))
      = VNumber 15
    ```
---

- [dune](https://dune.readthedocs.io/en/stable/index.html)
  - [dune ファイルの書き方](https://dune.readthedocs.io/en/stable/reference/dune/index.html)
  - [dune によるテスト](https://dune.readthedocs.io/en/stable/tests.html)
