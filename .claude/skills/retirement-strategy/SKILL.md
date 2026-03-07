---
name: retirement-strategy
description: Retirement asset and ETF portfolio strategist. Use when the user provides their ETF holdings list and target return rate and wants: market data analysis, backtesting-based rebalancing suggestions, and a monthly investment report (optionally formatted for Notion).
---

# Retirement Strategy Skill

Generate personalized ETF portfolio analysis and rebalancing reports based on current market data.

## Workflow

### 1. Receive Input
Ask the user for:
- Current ETF holdings: ticker symbols + allocation % (e.g., `VOO 40%, QQQ 20%, TIGER200 20%, KODEX배당성장 20%`)
- Target annual return rate (e.g., 7%)
- Investment horizon: years to retirement
- Risk tolerance: Conservative / Moderate / Aggressive
- Rebalancing frequency: Monthly / Quarterly / Annually
- Notion output: Yes / No

### 2. Fetch Market Data
Use WebSearch to get current ETF data:
```
WebSearch: "<ticker> ETF price return 2026 YTD performance"
WebSearch: "글로벌 시장 지수 ETF 성과 2026년"
WebSearch: "TIGER KODEX ETF 수익률 2026"
```

For each holding, collect:
- Current price
- YTD return
- 1-year / 3-year / 5-year annualized return
- Expense ratio
- Dividend yield

### 3. Portfolio Analysis

Calculate current portfolio metrics:
```
Weighted Return = Σ(allocation_i × return_i)
Weighted Expense = Σ(allocation_i × expense_ratio_i)
```

Compare against:
- Target return rate
- Benchmark: MSCI World / KOSPI 200

Identify:
- Underperforming holdings
- Overconcentration risks
- Currency exposure (KRW vs USD)

### 4. Rebalancing Suggestion

Based on backtesting logic and current market conditions:

```markdown
## 리밸런싱 제안

### 현재 포트폴리오
| ETF | 현재 비중 | YTD 수익률 | 권장 비중 |
|-----|---------|-----------|---------|
| VOO | 40% | +X.X% | 35% |
| ... | ... | ... | ... |

### 변경 사항
- VOO 40% → 35% (-5%p): 과도한 미국 대형주 집중 완화
- TIGER200 20% → 25% (+5%p): 국내 밸류에이션 매력

### 예상 포트폴리오 지표
- 예상 연수익률: X.X%
- 예상 변동성: X.X%
- 샤프 비율: X.XX
```

### 5. Monthly Investment Report

```markdown
# 월간 투자 보고서 — YYYY년 MM월

## 포트폴리오 현황
<Table with current values>

## 시장 동향 요약
<2–3 key macro events affecting the portfolio>

## 이달의 행동 항목
- [ ] VOO 5% 비중 축소
- [ ] TIGER200 5% 비중 확대
- [ ] 배당 재투자: ₩XXX

## 목표 달성 현황
- 목표 수익률: X% | 현재 YTD: X%
- 은퇴까지: X년 X개월
- 현재 자산: ₩XX,XXX,XXX
```

### 6. Notion Output (optional)
If Notion output requested, format report as Notion-compatible Markdown blocks:
- Use H1/H2/H3 headers
- Use callout blocks for warnings: `> ⚠️ Warning text`
- Use toggle blocks for detailed breakdowns
- Include a "Last Updated" date property

Provide instructions:
```
Notion에 붙여넣기 방법:
1. 새 Notion 페이지 생성
2. /markdown 블록 입력 → 아래 내용 붙여넣기
또는 Notion API를 통해 자동 업데이트 (토큰 필요)
```

### 7. Save Files
- Monthly report: `월간투자보고서_YYYYMM.md` (user-specified location)
- Notion export: `월간투자보고서_YYYYMM_notion.md`

## Tips
- Focus on low-cost index ETFs for core holdings; satellites for growth
- KRW-hedged vs unhedged: consider currency outlook in analysis
- Always note: this is analysis assistance, not licensed financial advice
- For Korean market ETFs, check TIGER/KODEX/KINDEX product pages for accurate TER
