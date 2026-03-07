---
name: polyglot-code-converter
description: Polyglot code converter between R, Python, and Julia. Use when the user provides source code in one language and wants it converted to another, with visualization library mapping (ggplot2→Plotly, etc.) and unit tests generated.
---

# Polyglot Code Converter (R ↔ Python ↔ Julia)

Convert data analysis scripts between R, Python, and Julia while preserving logic and mapping visualization libraries.

## Workflow

### 1. Receive Input
Ask the user for:
- Source code (paste or file path)
- Source language: R / Python / Julia
- Target language: R / Python / Julia
- Visualization preference: auto-map (default) / specify library

### 2. Analyze Source Code
Parse the code for:
- Data I/O operations (CSV/Excel loading, serial port reading)
- Statistical computations (mean, FFT, regression, impedance fitting)
- Visualization calls
- Control flow and logic
- Package/library dependencies

### 3. Language & Library Mapping

#### Data Manipulation
| R | Python | Julia |
|---|--------|-------|
| `data.frame` | `pd.DataFrame` | `DataFrame` (DataFrames.jl) |
| `dplyr::filter` | `df.query()` | `filter(df, ...)` |
| `tidyr::pivot_longer` | `df.melt()` | `stack(df)` |
| `readr::read_csv` | `pd.read_csv()` | `CSV.read()` |

#### Visualization
| R (ggplot2) | Python (Plotly/Matplotlib) | Julia (Plots.jl) |
|------------|--------------------------|-----------------|
| `ggplot(aes(x,y))` | `px.scatter(df, x=, y=)` | `plot(x, y)` |
| `geom_line()` | `go.Scatter(mode='lines')` | `plot!(x, y)` |
| `geom_histogram()` | `px.histogram()` | `histogram(x)` |
| `facet_wrap()` | `px.facet_col()` | `layout(...)` |
| `theme_minimal()` | `template='plotly_white'` | `theme(:minimal)` |

#### Signal Processing (SkinSensor-specific)
| Operation | R | Python | Julia |
|-----------|---|--------|-------|
| FFT | `fft(x)` (stats) | `np.fft.fft(x)` | `fft(x)` (FFTW.jl) |
| Impedance fit | `nls()` | `scipy.optimize.curve_fit()` | `LsqFit.curve_fit()` |
| Serial read | `serial` pkg | `pyserial` | `LibSerialPort.jl` |

### 4. Generate Converted Code

Produce the target code with:
- Equivalent package imports
- Preserved variable names (snake_case throughout)
- Inline comments explaining non-obvious translations
- Type annotations where idiomatic

### 5. Generate Unit Tests

Create a test file that verifies output consistency:

**Python (pytest)**:
```python
import pytest
import numpy as np

def test_impedance_calculation():
    Z1, Z2, alpha = 10.5, 8.3, 0.85
    expected = Z1 - alpha * Z2
    result = compute_ssc(Z1, Z2, alpha)
    assert abs(result - expected) < 1e-6
```

**R (testthat)**:
```r
test_that("impedance calculation matches", {
  expect_equal(compute_ssc(10.5, 8.3, 0.85), 10.5 - 0.85 * 8.3, tolerance = 1e-6)
})
```

**Julia (Test.jl)**:
```julia
using Test
@test compute_ssc(10.5, 8.3, 0.85) ≈ 10.5 - 0.85 * 8.3 atol=1e-6
```

### 6. Environment Setup Suggestion

Provide a setup snippet for VS Code / Cursor:

```json
// .vscode/settings.json additions
{
  "python.defaultInterpreterPath": "./venv/bin/python",
  "r.rpath.linux": "/usr/bin/R",
  "julia.executablePath": "/usr/local/bin/julia"
}
```

### 7. Save Files
- Converted code: `<original_name>_<target_lang>.<ext>`
- Tests: `test_<original_name>.<ext>`

## Tips
- For SkinSensor impedance data, keep `numpy`/`scipy` in Python as primary; Julia for heavy FFT workloads
- Arduino `.ino` files can be read via serial in Python with `pyserial` — offer to generate reader stub
- Always run a logical consistency check: output summary statistics should match between source and converted code
