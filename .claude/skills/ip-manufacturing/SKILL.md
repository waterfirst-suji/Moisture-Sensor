---
name: ip-manufacturing
description: IP and manufacturing research agent for product ideas. Use when the user has a product design idea or memo and wants: manufacturing cost research (China suppliers), utility model (실용신안) specification draft assistance, and monetization strategy suggestions.
---

# IP & Manufacturing Research Agent

Turn product ideas into actionable manufacturing and IP roadmaps.

## Workflow

### 1. Receive Input
Accept one of:
- Product idea description (free text)
- Design sketch or specification (file path to image/PDF/DOCX)
- Concept memo

Ask the user for:
- Target market: Korea / Global / Both
- IP priority: Utility Model (실용신안) / Invention Patent / Trade Secret
- Budget range for manufacturing PoC

### 2. Manufacturing Research

Search for comparable products and manufacturers:

```
WebSearch: "<product concept> manufacturer China Alibaba OEM price"
WebSearch: "<technology> 중국 제조 업체 OEM 단가"
WebSearch: "similar product AliExpress wholesale <keywords>"
```

Extract and structure:
- Unit cost range (low / medium / high volume)
- MOQ (Minimum Order Quantity)
- Lead time
- 2–3 recommended suppliers with ratings

**Output table**:
```markdown
| 항목 | 내용 |
|------|------|
| 유사 제품명 | ... |
| 중국 제조 단가 (1개) | ¥XX (~₩X,XXX) |
| 중국 제조 단가 (100개) | ¥XX (~₩X,XXX) |
| MOQ | XX개 |
| 납기 | X~X주 |
| 추천 업체 | Alibaba: XXX (★4.8, 500+ orders) |
```

### 3. IP Analysis

#### Freedom-to-Operate (FTO) Check
Search existing KR/US patents for blocking claims:
```
WebSearch: "site:patents.google.com <technology keyword> KR patent"
WebSearch: "KIPRIS 실용신안 <기술 키워드>"
```

#### Utility Model (실용신안) Draft Guide
For KR utility model registration, assist with:

```markdown
## 실용신안 명세서 초안

### 고안의 명칭
<Name of the utility model>

### 기술분야
<Technical field — e.g., 피부 측정 장치 기술분야>

### 배경기술
<Problem with existing solutions>

### 고안의 목적
<What this utility model solves>

### 고안의 구성
<Structural elements and how they work together>

### 청구범위 (Claims)
**청구항 1** (독립항): ...에 있어서, ...을 포함하는 것을 특징으로 하는 장치.
**청구항 2** (종속항): 제1항에 있어서, ...

### 도면의 간단한 설명
<Reference to diagrams in 06_도면/>
```

### 4. Monetization Strategy

Based on the product concept and IP position, suggest:

| 전략 | 설명 | 적합 조건 |
|------|------|---------|
| OEM 판매 | 제조 후 B2B 납품 | 대량 수요 확보 시 |
| 라이선싱 | 특허 기술 사용료 | 강한 IP + 대기업 파트너 |
| 직접 판매 | 스마트스토어 / 해외 직구 | 소량 고마진 제품 |
| 정부과제 | 연구개발 자금 확보 | 기술 검증 단계 |
| 크라우드펀딩 | 와디즈 / 킥스타터 | 소비자 검증 + 초기 자금 |

### 5. Save Files
- Manufacturing report: `02_프로젝트문서/manufacturing_research_<date>.md`
- Utility model draft: `04_특허/실용신안_초안_<product>_<date>.md`

## SkinSensor Context
- Reference our existing patent strategy in `04_특허/특허명세서_초안.docx`
- Phase 1 PoC budget: ₩100,000 (reference for cost sensitivity)
- Target: 정부과제 수주 + 대학내 스타트업 창업
- Corneometer benchmark: ₩300~500만원 (our competitive advantage: ₩4만원 PoC)
