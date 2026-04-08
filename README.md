# Semester Thesis — Dexterous Manipulation of Unknown Objects

**Author:** Carsten Oertel
**University:** Technical University of Munich (TUM)
**Chair:** Robotics, Artificial Intelligence and Real-time Systems (I6/AIR)
**Supervisor:** Prof. Knoll | **Advisor:** Zhang Chi, M.Sc.
**Industry Partner:** Agile Robots SE

## Latest PDF

The most recent compiled version of the thesis can be found at:

[`Report/main.pdf`](Report/main.pdf)

## Building from Source

Requires a TeX Live installation with `pdflatex` and `biber`.

```bash
cd Report
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

## Editor Setup

### Option A — VSCode (recommended)

1. Install [TeX Live](https://tug.org/texlive/) (full installation)
2. Install the [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) extension
3. Add the following to your VSCode `settings.json` (`Ctrl+Shift+P` → *Open User Settings (JSON)*):

```json
"latex-workshop.latex.tools": [
    {
        "name": "pdflatex",
        "command": "pdflatex",
        "args": ["-synctex=1", "-shell-escape", "-interaction=nonstopmode", "%DOC%"]
    },
    {
        "name": "biber",
        "command": "biber",
        "args": ["%DOCFILE%"]
    }
],
"latex-workshop.latex.recipes": [
    {
        "name": "pdflatex → biber → pdflatex × 2",
        "tools": ["pdflatex", "biber", "pdflatex", "pdflatex"]
    }
],
"latex-workshop.latex.recipe.default": "first",
"latex-workshop.view.pdf.viewer": "tab",
"latex-workshop.latex.autoBuild.run": "onSave",
"latex-workshop.latex.search.rootFiles.exclude": ["**/cover.tex"],
"latex-workshop.latex.rootFile.doNotPrompt": true
```

> **Note:** The last two lines prevent LaTeX Workshop from auto-detecting `Report/cover.tex` as a root file. `cover.tex` is a standalone document used only for printing the physical thesis cover and currently fails to compile against the latest `AIRlatex.cls`; excluding it ensures saves only build `main.tex`.

4. Open `Report/main.tex` — the PDF will build automatically on save (`Ctrl+S`).
   View the PDF with `Ctrl+Alt+V`. Click in the PDF to jump to source (SyncTeX).

### Option B — TeXstudio

1. Install [TeX Live](https://tug.org/texlive/) (full installation)
2. Install [TeXstudio](https://www.texstudio.org/)
3. Enable `-shell-escape`:
   *Options → Configure TeXstudio → Commands*
   Set **PdfLaTeX** to:

   ```text
   pdflatex -synctex=1 -shell-escape -interaction=nonstopmode %.tex
   ```

4. Set biber as bibliography backend:
   *Options → Configure TeXstudio → Build*
   Set **Default Bibliography Tool** to `txs:///biber`
5. **Optional — autocomplete for AIRlatex commands:** Copy [`AIRlatex.cwl`](../AIRlatex.cwl) (repo root) to:
   - Windows: `%APPDATA%\texstudio\completion\user\`
   - Linux/Mac: `~/.config/texstudio/completion/user/`

   This adds completions for commands like `\vec{}`, `\diff{}{}`, `\mat{}`, etc.
   *(VSCode does not need this — LaTeX Workshop scans the `.cls` file automatically.)*

6. Open `Report/main.tex` and compile with `F5`.
