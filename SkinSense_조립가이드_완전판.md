# SkinSense 프로토타입 조립 완전 가이드
> 알리익스프레스 구매 부품 기준 | Phase 1 PoC | 전자공학 무경험자 OK

---

## 목차
1. [부품 목록 최종 확정 (BOM)](#1-부품-목록-최종-확정-bom)
2. [부품 식별법](#2-부품-식별법)
3. [회로 배선 가이드](#3-회로-배선-가이드)
4. [아두이노 세팅 (소프트웨어)](#4-아두이노-세팅-소프트웨어)
5. [전체 코드 (복붙용)](#5-전체-코드-복붙용)
6. [단계별 실험 프로토콜](#6-단계별-실험-프로토콜)
7. [트러블슈팅](#7-트러블슈팅)
8. [Phase 2 업그레이드 로드맵](#8-phase-2-업그레이드-로드맵)

---

## 1. 부품 목록 최종 확정 (BOM)

### 장바구니 기존 부품 평가

| 부품 | 가격 | 판정 | 이유 |
|------|------|------|------|
| NI USB-6501 DAQ | ₩58,800 | ❌ 구매 취소 | 디지털 I/O 전용 — 아날로그 주파수 변화를 읽을 수 없음. Arduino Nano로 대체하면 5,000원 + 성능 우수 |
| WL02 와전류 센서 | ₩24,450 | ✅ 구매 | 핵심 부품. 코일 직접 감을 필요 없이 즉시 실험 가능 |
| PTC 히터 24V | ₩1,463 | ⏸ 보류 | Phase 2 온도 의존성 실험용. 지금은 불필요 |
| PTC 히터 5V | ₩1,095 | ⏸ 보류 | Phase 2에서 5V 버전으로 구매 |

> **절감 포인트**: USB-6501 제거로 약 ₩58,000 절감 → 더 좋은 부품 구성 가능

---

### Phase 1 즉시 구매 목록 (총 약 ₩35,000~45,000)

| # | 부품명 | 알리 검색 키워드 | 수량 | 가격(예상) | 비고 |
|---|--------|----------------|------|-----------|------|
| 1 | **WL02 와전류 센서** | `WL02 eddy current sensor` | 1 | ₩24,450 | 장바구니 그대로 구매 |
| 2 | **Arduino Nano V3** | `Arduino Nano V3 CH340` | 1 | ₩3,000~5,000 | CH340 칩 버전 OK |
| 3 | **VL53L0X 거리 센서** | `VL53L0X GY-530 ToF` | 1 | ₩2,000~3,500 | I2C 방식 레이저 거리계 |
| 4 | **MLX90614 온도 센서** | `MLX90614 GY-906 IR` | 1 | ₩3,000~5,000 | 비접촉 적외선 온도계 |
| 5 | **OLED 0.96인치** | `0.96 OLED I2C SSD1306` | 1 | ₩1,500~2,500 | SSD1306 칩, I2C 버전 |
| 6 | **브레드보드 830핀** | `breadboard 830` | 1 | ₩1,000~2,000 | 납땜 없이 조립 가능 |
| 7 | **점퍼선 세트** | `jumper wire male to male` | 1 | ₩1,000~1,500 | 수-수 타입 40핀 이상 |
| 8 | **Mini-B USB 케이블** | `mini usb cable arduino` | 1 | ₩1,000 | Arduino Nano 전원용 |

> **구매 팁**
> - 같은 판매자에서 여러 개 묶음 구매 시 배송비 절약
> - `Choice` 배지 상품 선택 → 1~2주 빠른 배송
> - 급하면 **디바이스마트(devicemart.co.kr)** 또는 **엘레파츠(eleparts.co.kr)** → 당일/익일 배송 가능 (단가 2~3배)
> - WL02는 'Amy Electronic Store' 평점 4.7, 판매 900건+ 신뢰 가능

---

### Phase 2 추가 구매 목록 (Phase 1 성공 후)

| # | 부품명 | 용도 | 예상 비용 |
|---|--------|------|----------|
| 1 | LDC1612 인덕턴스 변환 IC | 와전류 정밀 측정 (26,000배 향상) | ₩5,000~8,000 |
| 2 | ESP32-S3 개발보드 | Wi-Fi/BLE + 고성능 MCU | ₩8,000~12,000 |
| 3 | PCB 코일 (JLCPCB 발주) | 스파이럴 평면 코일, Rogers RO4350B | ₩500/개 (100개 발주) |
| 4 | Si5351 PLL 클락 제너레이터 | 100MHz 클린 사인파 발생 | ₩3,000~5,000 |
| 5 | NanoVNA-H4 | 정밀 임피던스 측정 | ₩50,000~80,000 |

---

## 2. 부품 식별법

택배 도착 후 작은 비닐 봉지에서 꺼낼 때 참고하세요.

### 2-1. WL02 와전류 센서
```
[외형]
┌─────────────────────────────┐
│  동그란 코일 (갈색 PCB)       │
│  나선형 구리 패턴, 직경 3~5cm  │
│                              │
│  + 파란/녹색 컨트롤러 보드     │
│  (WL02 인쇄 글자 확인!)       │
└─────────────────────────────┘

[선 색상]
빨강  → VCC (전원 +)
검정  → GND (접지 -)
파랑 또는 노랑 → OUT (아날로그 신호 출력)

[주의] 보드 뒷면에 VCC/GND/OUT 인쇄된 글자 반드시 확인!
```

### 2-2. Arduino Nano V3
```
[외형]
- USB 메모리보다 약간 큰 보드 (45mm x 18mm)
- 파란색 또는 검정색
- 양쪽에 금색 핀 15개씩 (총 30핀)
- 한쪽 끝에 Mini-B USB 포트 (작은 사다리꼴 모양)

[핀 배치 - 중요!]
왼쪽 열:  D13 D12 D11 D10 D9 D8 D7 D6 D5 D4 D3 D2 GND RST RX
오른쪽 열: D13(LED) 3V3 REF A0 A1 A2 A3 A4(SDA) A5(SCL) A6 A7 5V RST GND VIN
```

### 2-3. VL53L0X (GY-530)
```
[외형]
- 아주 작은 보드 (13mm x 18mm)
- 보라색 또는 파란색
- 중앙에 검은 사각형 (레이저 발신부) + 작은 렌즈
- 핀: VIN, GND, SDA, SCL (4핀 또는 6핀)
- I2C 주소: 0x29 (고정)
```

### 2-4. MLX90614 (GY-906)
```
[외형]
- 은색 원통형 캔 (TO-39 패키지)이 PCB에 납땜됨
- 앞면에 작은 창 (적외선 렌즈) → 이 창을 피부 방향으로!
- 핀: VCC, GND, SDA, SCL
- I2C 주소: 0x5A (고정)
- FOV: 90도 시야각 (1cm 거리에서 약 2cm 직경 측정)
```

### 2-5. OLED 0.96인치
```
[외형]
- 약 2.5cm x 2.5cm 작은 화면
- 핀에 GND, VCC, SCL, SDA 인쇄되어 있으면 I2C 버전 (OK!)
- I2C 주소: 0x3C 또는 0x3D
- 주의: VCC가 3.3V 또는 5V 입력 가능한지 확인 (대부분 둘 다 OK)
```

### 2-6. 브레드보드 구조 이해
```
[핵심 개념]
세로(컬럼): a-b-c-d-e 5개 구멍이 내부에서 연결됨 (같은 줄 = 같은 선)
           f-g-h-i-j도 같지만 중앙 홈으로 분리

전원 레일:  상단/하단 긴 가로줄 (+, - 표시)
           가로로 전체 연결 → 5V 전원과 GND 배분용

시각화:
 + - - - - - - - - - - - - - - +  ← + 레일 (5V 또는 3.3V)
 - - - - - - - - - - - - - - - -  ← - 레일 (GND)
 a b c d e     f g h i j
 ■ ■ ■ ■ ■     ■ ■ ■ ■ ■  ← 같은 숫자 줄 연결 (예: 1번 줄)
 ■ ■ ■ ■ ■     ■ ■ ■ ■ ■
   [ 중앙 홈 — 분리됨 ]
```

---

## 3. 회로 배선 가이드

### 3-1. 전체 연결 다이어그램

```
┌─────────────────────────────────────────────────────────────┐
│                    Arduino Nano                              │
│                                                              │
│  [WL02 와전류 센서]                                           │
│  VCC ────────────────────── 5V                              │
│  GND ────────────────────── GND                             │
│  OUT ────────────────────── A0 (아날로그 입력)               │
│                                                              │
│  [VL53L0X 거리 센서]   I2C 버스                              │
│  VIN ────────────────── 3.3V                                │
│  GND ────────────────── GND                                 │
│  SDA ──┐                                                    │
│  SCL ──┼───────────────── A4(SDA) / A5(SCL)                │
│        │                                                    │
│  [MLX90614 온도 센서]  ↕ 같은 I2C 버스 공유                  │
│  VCC ────────────────── 3.3V                                │
│  GND ────────────────── GND                                 │
│  SDA ──┤                                                    │
│  SCL ──┤                                                    │
│        │                                                    │
│  [OLED 0.96" 디스플레이] ↕ 같은 I2C 버스 공유               │
│  VCC ────────────────── 3.3V (또는 5V)                      │
│  GND ────────────────── GND                                 │
│  SDA ──┘                                                    │
│  SCL ───────────────── A5(SCL)                              │
└─────────────────────────────────────────────────────────────┘

I2C 주소 충돌 없음 확인:
  VL53L0X  → 0x29
  MLX90614 → 0x5A
  OLED     → 0x3C
```

---

### STEP 1. 브레드보드에 Arduino Nano 꽂기

```
1. 브레드보드 중앙 홈을 걸치도록 Arduino Nano를 꽂는다
2. USB 포트가 보드 끝쪽 (1번 줄 방향)을 향하게 배치
3. 양쪽 핀이 a~e 줄, f~j 줄에 각각 들어가야 함
4. 안 들어가면 절대 억지로 누르지 말고 → 부드럽게 비틀며 삽입

확인: 모든 핀이 브레드보드 구멍에 완전히 들어갔는지 육안으로 확인
```

---

### STEP 2. 전원 레일 연결

```
점퍼선 2개 필요:

빨간 점퍼선: Arduino 5V 핀 → 브레드보드 + 레일 (빨간 줄)
검정 점퍼선: Arduino GND 핀 → 브레드보드 - 레일 (파란/검정 줄)

[주의] 3.3V가 필요한 센서용으로 별도 레일 구성 권장:
파란 점퍼선: Arduino 3.3V 핀 → 브레드보드 반대편 + 레일
```

---

### STEP 3. WL02 와전류 센서 연결

```
WL02 보드      브레드보드 레일/핀
─────────────────────────────────
VCC    ──→    + 레일 (5V)
GND    ──→    - 레일 (GND)
OUT    ──→    Arduino A0 핀 (아날로그 신호)

[코일 배치]
- 코일의 평면 부분이 피부를 향하도록 설치
- 코일과 피부 사이 간격: 1~5mm 유지
- 처음 실험: 5mm에서 시작해서 점차 줄이기

[출력 특성]
- 아날로그 전압: 0~5V
- Arduino 10bit ADC: 0~1023 값
- 공기 중 기준값: 약 490~520 (중간값)
- 금속/도체 접근 시 값 변화
```

---

### STEP 4. VL53L0X 거리 센서 연결 (I2C)

```
VL53L0X 보드   브레드보드 레일/핀
─────────────────────────────────
VIN    ──→    + 레일 (3.3V) ← 주의! 5V 아님
GND    ──→    - 레일 (GND)
SDA    ──→    Arduino A4 핀 (I2C 데이터)
SCL    ──→    Arduino A5 핀 (I2C 클락)

[I2C 이해: 집 주소 비유]
하나의 도로(SDA/SCL 2선)에 여러 집(센서)이 있고
각각 고유 주소(0x29, 0x5A, 0x3C)가 있어 혼선 없음!

[성능]
- 측정 범위: 50mm ~ 2000mm
- 오차: ±3% (근접 1~50mm에서는 ±1mm)
- 코일-피부 거리 실시간 보정에 사용
```

---

### STEP 5. MLX90614 온도 센서 연결 (I2C)

```
MLX90614 보드  브레드보드 레일/핀
─────────────────────────────────
VCC    ──→    + 레일 (3.3V)
GND    ──→    - 레일 (GND)
SDA    ──→    Arduino A4 핀 (VL53L0X와 동일 줄)
SCL    ──→    Arduino A5 핀 (VL53L0X와 동일 줄)

[배치 주의]
- 은색 캔의 창(렌즈)을 피부 방향으로
- 피부에서 1cm 거리에서 약 2cm 직경 영역 평균 온도 측정
- 정밀도: ±0.5°C (실온 부근)
```

---

### STEP 6. OLED 디스플레이 연결 (I2C)

```
OLED 보드      브레드보드 레일/핀
─────────────────────────────────
VCC    ──→    + 레일 (3.3V 또는 5V)
GND    ──→    - 레일 (GND)
SDA    ──→    Arduino A4 핀 (동일 I2C 버스)
SCL    ──→    Arduino A5 핀 (동일 I2C 버스)

[확인] 이 단계에서 3개 센서 + OLED가 모두 A4/A5에 연결됨
→ 같은 핀에 여러 부품 연결이 맞음! (I2C 버스는 병렬 연결)
```

---

### STEP 7. 최종 배선 체크리스트

배선 완료 후 USB 연결 전에 반드시 확인:

- [ ] Arduino 5V 핀 → 브레드보드 + 레일 (빨간 줄)
- [ ] Arduino GND 핀 → 브레드보드 - 레일 (파란 줄)
- [ ] Arduino 3.3V 핀 → 브레드보드 별도 + 레일
- [ ] WL02: VCC→5V레일, GND→GND레일, OUT→A0
- [ ] VL53L0X: VIN→3.3V레일, GND→GND레일, SDA→A4, SCL→A5
- [ ] MLX90614: VCC→3.3V레일, GND→GND레일, SDA→A4, SCL→A5
- [ ] OLED: VCC→3.3V레일, GND→GND레일, SDA→A4, SCL→A5
- [ ] 쇼트 여부 확인: 빨간-검정 레일이 서로 닿지 않는지 확인

---

## 4. 아두이노 세팅 (소프트웨어)

### STEP 1. Arduino IDE 다운로드

```
https://www.arduino.cc/en/software
→ 자신의 OS에 맞는 버전 다운로드 → 설치
⚠️ 중요: 설치 중 'USB 드라이버 설치?' 팝업 → 반드시 [설치] 클릭!
```

### STEP 2. CH340 드라이버 설치 (알리 구매 필수!)

```
알리익스프레스 Nano는 대부분 CH340 칩 사용
이 드라이버 없으면 PC가 Arduino를 인식하지 못함!

Windows: https://sparks.gogo.co.nz/ch340.html → INSTALL 클릭
Mac: https://github.com/adrianmihalko/ch340g-ch34g-ch34x-mac-os-x-driver

확인 방법:
- Arduino USB 연결 후 장치관리자 실행
- '포트(COM & LPT)' 항목에서 'USB-SERIAL CH340 (COM3)' 확인
- COM 번호가 보이면 성공!
```

### STEP 3. Arduino IDE 보드 설정

```
도구(Tools) → 보드(Board) → 'Arduino Nano' 선택
도구(Tools) → 프로세서(Processor) → 'ATmega328P (Old Bootloader)' 선택
                                      ← 알리 제품은 Old Bootloader!
도구(Tools) → 포트(Port) → 인식된 COM 포트 선택 (예: COM3)
```

### STEP 4. 라이브러리 4개 설치

```
스케치(Sketch) → 라이브러리 포함(Include Library) → 라이브러리 관리(Manage Libraries)

설치 목록:
① VL53L0X  → 검색: "VL53L0X" → Pololu VL53L0X 설치
② MLX90614 → 검색: "MLX90614" → Adafruit MLX90614 설치
③ Adafruit GFX    → 검색: "Adafruit GFX" → 설치
④ Adafruit SSD1306 → 검색: "Adafruit SSD1306" → 설치

설치 시 의존성 팝업 뜨면 → [Install all] 클릭
```

---

## 5. 전체 코드 (복붙용)

```cpp
/*
 * SkinSense Phase 1 - 피부 수분 측정 프로토타입
 * 부품: Arduino Nano + WL02 + VL53L0X + MLX90614 + OLED
 * 출력: Serial (CSV) + OLED 실시간 표시
 */

#include <Wire.h>
#include <VL53L0X.h>
#include <Adafruit_MLX90614.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// ── 핀 정의 ──────────────────────────────────────────
#define EDDY_PIN     A0   // WL02 아날로그 출력
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64

// ── 객체 생성 ─────────────────────────────────────────
VL53L0X          distSensor;
Adafruit_MLX90614 tempSensor;
Adafruit_SSD1306  display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);

// ── 전역 변수 ─────────────────────────────────────────
long     baselineEddy = -1;   // 공기 중 기준값
unsigned long lastTime = 0;

// ────────────────────────────────────────────────────
void setup() {
  Serial.begin(115200);
  Wire.begin();

  // VL53L0X 초기화
  distSensor.init();
  distSensor.setTimeout(500);
  distSensor.startContinuous();

  // MLX90614 초기화
  tempSensor.begin();

  // OLED 초기화
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
  display.clearDisplay();
  display.setTextColor(WHITE);

  // 시리얼 헤더 출력
  Serial.println("timestamp,eddy_raw,eddy_shift,distance_mm,skin_temp_C,ambient_temp_C");

  // 기준값 측정 (첫 3초)
  Serial.println("# 기준값 측정 중... 코일 주변에 아무것도 놓지 마세요");
  delay(1000);
  long sum = 0;
  for (int i = 0; i < 30; i++) {
    sum += analogRead(EDDY_PIN);
    delay(100);
  }
  baselineEddy = sum / 30;
  Serial.print("# 기준값(Baseline): ");
  Serial.println(baselineEddy);
}

// ────────────────────────────────────────────────────
void loop() {
  // 100ms 주기
  if (millis() - lastTime < 100) return;
  lastTime = millis();

  // ── 센서 읽기 ──────────────────────────────────────
  int  eddyRaw   = analogRead(EDDY_PIN);
  long eddyShift = eddyRaw - baselineEddy;       // 기준 대비 변화량
  int  distMM    = distSensor.readRangeContinuousMillimeters();
  float skinTemp = tempSensor.getObjectTempC();
  float ambTemp  = tempSensor.getAmbientTempC();

  // ── 시리얼 CSV 출력 ────────────────────────────────
  Serial.print(millis());       Serial.print(",");
  Serial.print(eddyRaw);        Serial.print(",");
  Serial.print(eddyShift);      Serial.print(",");
  Serial.print(distMM);         Serial.print(",");
  Serial.print(skinTemp, 2);    Serial.print(",");
  Serial.println(ambTemp, 2);

  // ── OLED 출력 ──────────────────────────────────────
  display.clearDisplay();
  display.setTextSize(1);

  display.setCursor(0, 0);
  display.print("Eddy: "); display.print(eddyRaw);
  display.print(" ("); display.print(eddyShift > 0 ? "+" : ""); display.print(eddyShift); display.print(")");

  display.setCursor(0, 16);
  display.print("Dist: "); display.print(distMM); display.print(" mm");

  display.setCursor(0, 32);
  display.print("Skin: "); display.print(skinTemp, 1); display.print(" C");

  display.setCursor(0, 48);
  display.print("Amb : "); display.print(ambTemp, 1); display.print(" C");

  display.display();
}
```

### 업로드 방법

```
1. File → New → 기존 코드 지우고 위 코드 붙여넣기
2. 체크(✓) 버튼 클릭 → 'Done compiling' 나오면 문법 OK
3. 화살표(→) 버튼 클릭 → 'Done uploading' 나오면 완료!
4. Tools → Serial Monitor → 속도 '115200' 설정 → 데이터 흐름 확인

[흔한 오류 해결]
avrdude: stk500_recv(): programmer is not responding
→ 도구(Tools) → 프로세서 → 'ATmega328P (Old Bootloader)' 로 변경!
```

### Python 데이터 수집 코드

```python
# skinsense_collector.py
# pip install pyserial pandas matplotlib

import serial
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from datetime import datetime

# ── 설정 ──────────────────────────────────────────────
PORT    = 'COM3'       # Windows: COM3, Mac/Linux: /dev/ttyUSB0
BAUD    = 115200
MAXROWS = 500          # 그래프에 표시할 최대 행 수

# ── 초기화 ────────────────────────────────────────────
ser = serial.Serial(PORT, BAUD, timeout=1)
data = []

fig, axes = plt.subplots(3, 1, figsize=(10, 8))
fig.suptitle('SkinSense 실시간 모니터')

def update(frame):
    global data
    while ser.in_waiting:
        line = ser.readline().decode('utf-8', errors='ignore').strip()
        if line.startswith('#') or 'timestamp' in line:
            continue
        parts = line.split(',')
        if len(parts) == 6:
            try:
                row = {
                    'time':      int(parts[0]) / 1000,
                    'eddy_raw':  int(parts[1]),
                    'eddy_shift':int(parts[2]),
                    'dist_mm':   int(parts[3]),
                    'skin_temp': float(parts[4]),
                    'amb_temp':  float(parts[5]),
                }
                data.append(row)
            except:
                pass

    if len(data) < 2:
        return

    df = pd.DataFrame(data[-MAXROWS:])

    for ax in axes:
        ax.clear()

    axes[0].plot(df['time'], df['eddy_shift'], 'b-', linewidth=1)
    axes[0].set_ylabel('와전류 변화량 (ADC)')
    axes[0].axhline(0, color='gray', linestyle='--')
    axes[0].set_title('맴돌이전류 신호')

    axes[1].plot(df['time'], df['dist_mm'], 'g-', linewidth=1)
    axes[1].set_ylabel('거리 (mm)')
    axes[1].set_title('코일-피부 거리')

    axes[2].plot(df['time'], df['skin_temp'], 'r-', label='피부온도')
    axes[2].plot(df['time'], df['amb_temp'],  'k-', label='실내온도', alpha=0.5)
    axes[2].set_ylabel('온도 (°C)')
    axes[2].set_xlabel('시간 (초)')
    axes[2].legend()
    axes[2].set_title('온도')

    plt.tight_layout()

ani = animation.FuncAnimation(fig, update, interval=200)
plt.show()
```

---

## 6. 단계별 실험 프로토콜

### Week 1: 하드웨어 조립 & 기본 동작 확인

**Day 1~2: 부품 도착 확인 & 조립**
- [ ] 부품 목록 대조 확인 (누락 없는지)
- [ ] 브레드보드에 Arduino Nano 장착
- [ ] WL02만 먼저 연결 (A0)
- [ ] USB 연결 → Serial Monitor에서 숫자 출력 확인

**Day 3~4: 기준값 측정**
```
실험 A: 공기 중 기준값
- 코일 주변에 아무것도 없는 상태로 30초 측정
- eddy_raw 값이 일정(예: 490~520 범위)하면 정상
- Serial Monitor의 Baseline 값 기록
```

**Day 5~7: 알루미늄 호일 테스트**
```
실험 B: 금속 거리 의존성
- 5cm x 5cm 알루미늄 호일 준비
- 5cm → 3cm → 2cm → 1cm → 접촉 순서로 접근
- 각 거리에서 5회 측정 후 평균 기록

성공 기준: 1cm 거리에서 eddy_shift 값이 ±50 이상 변화
           (변화 없으면 WL02 연결 문제 → 7절 트러블슈팅 참조)
```

| 거리 | eddy_raw 기록 | eddy_shift |
|------|--------------|-----------|
| 공기 (기준) | ___ | 0 |
| 5cm | ___ | ___ |
| 3cm | ___ | ___ |
| 2cm | ___ | ___ |
| 1cm | ___ | ___ |
| 접촉 | ___ | ___ |

---

### Week 2: I2C 센서 추가 & 다중 채널 수집

**Day 1~2: VL53L0X + MLX90614 + OLED 연결**
- [ ] 전체 코드 업로드 (5절 참조)
- [ ] I2C 스캔 코드로 3개 주소 확인 (아래 디버깅 코드 활용)

**I2C 스캐너 코드 (디버깅용)**
```cpp
// 이 코드 먼저 업로드해서 센서 연결 확인
#include <Wire.h>
void setup() {
  Wire.begin();
  Serial.begin(115200);
  Serial.println("I2C 스캔 시작...");
  for (byte addr = 8; addr < 127; addr++) {
    Wire.beginTransmission(addr);
    if (Wire.endTransmission() == 0) {
      Serial.print("발견! 주소: 0x");
      Serial.println(addr, HEX);
    }
  }
  Serial.println("완료!");
}
void loop() {}

// 정상 출력:
// 발견! 주소: 0x29  ← VL53L0X
// 발견! 주소: 0x3C  ← OLED
// 발견! 주소: 0x5A  ← MLX90614
```

**Day 3~7: 4채널 동시 수집 & CSV 저장**
- [ ] Python 데이터 수집 코드로 실시간 그래프 확인
- [ ] 1분간 데이터 수집 → CSV 파일 저장
- [ ] 성공 기준: 100ms 주기 안정적 데이터 출력

---

### Week 3: 전도도 비교 실험

```
실험 C: 다양한 물질 전도도 비교

준비물: 종이 3장, 물, 식염수(0.9% NaCl, 물 100mL + 소금 0.9g)

방법:
1. 종이를 건조 상태로 코일 1cm 아래 놓기 → 5회 측정
2. 같은 종이를 물에 적셔서 측정 → 5회
3. 식염수에 적셔서 측정 → 5회

기대 결과: 식염수 > 물 > 건조 순서로 eddy_shift 값 증가
(이것이 피부 수분 측정 원리의 검증!)
```

| 물질 | 평균 eddy_shift | 표준편차 |
|------|----------------|---------|
| 건조 종이 | ___ | ___ |
| 물 적신 종이 | ___ | ___ |
| 식염수 종이 | ___ | ___ |
| 알루미늄 호일 | ___ | ___ |

---

### Week 4: 보습 크림 PoC (핵심 실험!)

```
실험 D: 화장품 보습 효능 측정

준비물: 보습 크림, 유성펜, 자(ruler)

Step 1: 전완부(팔 안쪽) 3cm x 3cm 영역에 유성펜으로 표시
Step 2: 표시 영역에 코일을 1~2cm 위에 놓고 5회 측정 → '도포 전' 기록
Step 3: 보습 크림 0.1g (콩알 크기) 도포
Step 4: 각 시점마다 5회씩 측정
         - 도포 직후 (0분)
         - 1분 후
         - 5분 후
         - 10분 후
         - 30분 후
Step 5: Python으로 시계열 그래프 생성
```

| 시점 | 측정 1 | 2 | 3 | 4 | 5 | 평균 | 표준편차 |
|------|-------|---|---|---|---|------|---------|
| 도포 전 | | | | | | | |
| 직후 0분 | | | | | | | |
| 1분 후 | | | | | | | |
| 5분 후 | | | | | | | |
| 10분 후 | | | | | | | |
| 30분 후 | | | | | | | |

**성공 기준**: 보습 크림 도포 후 eddy_shift 값의 통계적 유의미한 변화 (t-test p < 0.05)
→ 이 결과가 특허 출원 + 논문의 핵심 데이터!

---

## 7. 트러블슈팅

### 문제 1: Arduino IDE에서 포트가 안 보임
```
원인: CH340 드라이버 미설치
해결: 4절 STEP 2 CH340 드라이버 설치 → 재시작
```

### 문제 2: 업로드 오류 (avrdude error)
```
원인: 보드 설정 오류
해결: Tools → Processor → 'ATmega328P (Old Bootloader)' 선택
```

### 문제 3: eddy_raw 값이 변화 없음
```
원인 1: WL02 연결 불량
해결:   A0 핀에 멀티미터로 전압 측정 (0~5V 사이인지 확인)
        VCC/GND 연결 재확인

원인 2: WL02 자체 불량 (알리 제품 10% 불량률)
해결:   동일 제품 재주문 or 국내 디바이스마트에서 구매
```

### 문제 4: I2C 센서 인식 안 됨
```
원인: SDA/SCL 선 연결 오류 또는 전압 문제
해결:
1. I2C 스캐너 코드 업로드 (6절 Week 2 참조)
2. 0x29, 0x5A, 0x3C 중 보이지 않는 센서 확인
3. 해당 센서의 VCC (3.3V!) 연결 재확인
4. SDA → A4, SCL → A5 연결 재확인
```

### 문제 5: OLED에 아무것도 안 보임
```
원인 1: I2C 주소 불일치
해결:   코드에서 0x3C → 0x3D로 변경 후 재업로드

원인 2: 전원 문제
해결:   VCC를 5V 레일에 연결 시도
```

### 문제 6: 피부 측정 시 변화가 너무 작음
```
이유: 피부는 약한 전도체라 변화가 금속보다 훨씬 미세함

개선 방법:
1. 코일과 피부 거리를 1mm까지 줄이기
2. 측정 횟수 늘리기 (5회 → 20회 평균)
3. 피부를 물로 살짝 적셔서 비교 (극단적 차이 확인용)
4. Phase 2 LDC1612 업그레이드 (26,000배 정밀도)
```

---

## 8. Phase 2 업그레이드 로드맵

Phase 1 성공 (보습 크림 효과 감지) 후 진행:

### 핵심 업그레이드: LDC1612 + ESP32

```
현재 (Phase 1)                     업그레이드 (Phase 2)
─────────────────────────────────────────────────────
Arduino Nano (10bit ADC)        →  ESP32-S3 (12bit, Wi-Fi/BLE)
WL02 와전류 모듈                 →  LDC1612 전용 IC (26,000배 정밀)
DIY 배선                        →  PCB 코일 (JLCPCB 발주)
단일 주파수                      →  2채널 다중 주파수 (1MHz + 100MHz)
```

### LDC1612 연결 구조

```
[PCB 코일 CH0] ─ LC 탱크(100MHz용) ─ LDC1612 CH0 ─┐
[PCB 코일 CH1] ─ LC 탱크(1MHz용)  ─ LDC1612 CH1 ─┼─ I2C ─ ESP32-S3
[VL53L0X]     ──────────────────────────────────────┤
[MLX90614]    ──────────────────────────────────────┘

CH0 (100MHz): 침투 깊이 δ ≈ 15μm → 각질층만 측정 (겉보습)
CH1 (1MHz):   침투 깊이 δ ≈ 150μm → 진피까지 측정 (속보습)

순수 각질층 신호 추출 (특허 핵심):
  S_sc = Z_CH0 - (α × Z_CH1)   [α = 0.1~0.3]
```

### PCB 코일 설계 스펙 (JLCPCB 발주용)
- 기판: FR4 (Rogers RO4350B 권장)
- 패턴: 스파이럴(Spiral) 평면 코일
- 외경: 8mm, 10턴
- 선폭: 0.2mm, 간격: 0.2mm
- 레이어: 2층 (Top + Bottom 동일 패턴 직렬)

---

*문서 버전: v1.0 | 2026년 3월 | SkinSense Phase 1 PoC*
