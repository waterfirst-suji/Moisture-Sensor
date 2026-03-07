---
name: scholar-bridge
description: Multilingual technical document translator and summarizer. Use when the user provides a PDF path, arXiv link, or DOI and wants a Korean/English structured summary that preserves LaTeX formulas, with optional Quarto (.qmd) output for web publishing.
---

# ScholarBridge Master Skill

Translate and summarize technical papers and standards with formula preservation. Optimized for biosensor, eddy current, and skin measurement literature.

## Workflow

### 1. Receive Input
Accept one of:
- Local file path: `05_연구자료/some_paper.pdf`
- arXiv URL: `https://arxiv.org/abs/XXXX.XXXXX`
- DOI string: `10.1109/...`
- Plain text paste of abstract/sections

Ask the user:
- Target language: Korean (default) / English / Both
- Output format: Markdown summary / Quarto `.qmd` / Both
- Depth: Abstract only / Section summaries / Full translation

### 2. Extract Content
For a local PDF, use the Read tool to extract text.
For a URL, use WebFetch to retrieve the abstract and key sections.

Identify and preserve:
- LaTeX math blocks: `$$...$$` or `\(...\)`
- Figure captions and table descriptions
- Section structure (Introduction, Methods, Results, Discussion)
- Key numerical results and units

### 3. Terminology Mapping (Korean ↔ English)
Apply domain-specific terms consistently:

| Korean | English |
|--------|---------|
| 맴돌이전류 | Eddy current |
| 각질층 | Stratum corneum |
| 침투깊이 | Skin depth |
| 임피던스 | Impedance |
| 와전류 센서 | Eddy current sensor |
| 공진 주파수 | Resonant frequency |
| 비접촉 | Non-contact |
| 유전율 | Permittivity |
| 전도도 | Conductivity |

### 4. Generate Summary Document

```markdown
# [논문 제목 / Paper Title]

**원문 / Source**: <citation>
**번역 / Translation Date**: YYYY-MM-DD
**요약 깊이 / Summary Depth**: Abstract only | Full

---

## 핵심 요약 (Korean)
<3–5 bullet points in Korean>

## Key Takeaways (English)
<3–5 bullet points in English>

## 핵심 수식 / Key Formulas
$$<preserved LaTeX>$$
> 의미: <한국어 설명>

## 섹션별 요약 / Section Summaries
### Introduction / 서론
...
### Methods / 방법론
...
### Results / 결과
...

## SkinSensor 연관성 / Relevance to SkinSensor
<How this paper relates to our eddy current skin sensor project>

## 참고문헌 / Reference
<Full citation in APA format>
```

### 5. Quarto Output (optional)
If `.qmd` format requested, wrap the document:

```yaml
---
title: "<paper title>"
author: "SkinSensor Team"
date: "YYYY-MM-DD"
format:
  html:
    toc: true
    code-fold: true
    math: mathjax
---
```

### 6. Save Files
- Markdown: `05_연구자료/<paper_slug>_번역요약.md`
- Quarto: `05_연구자료/<paper_slug>.qmd`

## Tips
- Always verify formula rendering with `$$` delimiters
- For Korean output, use formal academic register (존댓말 + 학술체)
- Cross-reference findings with our existing studies in `05_연구자료/`
