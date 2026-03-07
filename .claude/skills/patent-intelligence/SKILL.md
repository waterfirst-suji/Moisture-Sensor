---
name: patent-intelligence
description: Display & biosensor patent trend analyst. Use when the user wants to track competitor technology via patents, analyze patent trends for keywords like "Tandem OLED", "Micro-LED", "eddy current skin", or generate patent intelligence reports and dashboard data.
---

# Patent Intelligence Skill

Track competitor technology evolution through patent publications and generate structured analysis reports.

## Workflow

### 1. Gather Input
Ask the user for:
- Company name(s) or technology keyword(s) — e.g., "Samsung Display", "Tandem OLED", "eddy current skin sensor"
- Date range — defaults to last 12 months
- Output format — report only, or report + dashboard JSON

### 2. Search Patent Sources
Use WebSearch to find recent patents and technical disclosures:
```
Search: "<keyword> patent 2025 OR 2026 site:patents.google.com OR site:kipris.or.kr"
Search: "<company> patent filing <technology area> recent"
```

Also search for:
- KR (Korean) patent applications via KIPRIS
- US patents via Google Patents / USPTO
- JP/CN patents for competitive landscape

### 3. Analyze Each Patent
For each patent found, extract:
- **Title** and filing date
- **Core claim** — what physical phenomenon or method is protected
- **Key formula or circuit** if present
- **Differentiation** from SkinSensor's approach:
  - `S_sc = Z₁ - α×Z₂` (dual-frequency differential)
  - `Z_corr = Z / (1 + β(T - T_ref))` (AI temperature correction)
- **Freedom-to-operate** flag: does it overlap with SkinSensor claims?

### 4. Generate Report
Produce a structured Markdown report:

```markdown
# Patent Intelligence Report — <keyword>
**Date**: YYYY-MM-DD  **Analyst**: Claude

## Executive Summary
<2–3 sentence overview>

## Patent Landscape

### <Patent Title> — <Filing Date>
- **Applicant**: ...
- **Core Claim**: ...
- **FTO Risk**: Low / Medium / High
- **Differentiation from SkinSensor**: ...

## Trend Analysis
<Technology direction, filing frequency, whitespace areas>

## SkinSensor Positioning
<Where our claims are defensible; recommended claim strengthening>
```

### 5. Generate Dashboard JSON (optional)
If the user requested dashboard data, output a JSON block ready for a Streamlit chart:

```json
{
  "generated_at": "YYYY-MM-DD",
  "keyword": "<keyword>",
  "patents": [
    {
      "title": "...",
      "applicant": "...",
      "filing_date": "YYYY-MM-DD",
      "fto_risk": "Low|Medium|High",
      "country": "KR|US|JP|CN"
    }
  ],
  "trend_summary": "..."
}
```

### 6. Save Files
- Write report to `04_특허/patent_intelligence_<keyword>_<date>.md`
- Write JSON to `04_특허/dashboard_data_<keyword>_<date>.json` (if requested)

## Tips
- Focus on IPC codes: A61B5 (biomedical measurement), G01N27 (electrical measurement of biological materials)
- Cross-reference with SkinSensor's existing patent claims in `04_특허/특허명세서_초안.docx`
- Flag any "blocking" patents that could affect the 2-patent strategy
