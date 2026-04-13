#!/bin/bash
# ReadOnce: 같은 세션에서 동일 파일 중복 읽기 차단
# - offset/limit 지정된 분할 읽기는 허용 (대규모 편집 시 필요)
# - 5분 이내 동일 범위 재읽기만 차단

CACHE_DIR="/tmp/claude-read-cache-$(id -u)"
mkdir -p "$CACHE_DIR"

# python3 존재 확인
if ! command -v python3 &>/dev/null; then
  echo "⚠️ python3가 설치되어 있지 않습니다. ReadOnce 훅이 동작하지 않습니다." >&2
  echo "  macOS: xcode-select --install / Linux: sudo apt install python3" >&2
  exit 0
fi

# stdin에서 JSON 입력 읽기
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('tool_name',''))" 2>/dev/null)
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('file_path',''))" 2>/dev/null)
OFFSET=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('tool_input',{}).get('offset',''))" 2>/dev/null)

# Read 호출만 체크
if [ "$TOOL_NAME" != "Read" ] || [ -z "$FILE_PATH" ]; then
  exit 0
fi

# offset이 있으면 분할 읽기 → 항상 허용
if [ -n "$OFFSET" ] && [ "$OFFSET" != "None" ] && [ "$OFFSET" != "0" ]; then
  exit 0
fi

# 경로 정규화
NORM_PATH=$(python3 -c "import os,sys; print(os.path.realpath(sys.argv[1]))" "$FILE_PATH" 2>/dev/null || echo "$FILE_PATH")

# 해시로 캐시 파일명 생성
HASH=$(echo -n "$NORM_PATH" | md5 2>/dev/null || echo -n "$NORM_PATH" | md5sum | cut -d' ' -f1)
CACHE_FILE="$CACHE_DIR/$HASH"

# 캐시 파일 존재 + 5분 이내면 차단
if [ -f "$CACHE_FILE" ]; then
  CACHED_TIME=$(cat "$CACHE_FILE")
  NOW=$(date +%s)
  DIFF=$((NOW - CACHED_TIME))

  if [ "$DIFF" -lt 300 ]; then
    echo "이 파일은 ${DIFF}초 전에 이미 읽었습니다. 컨텍스트의 기존 내용을 사용하세요: $FILE_PATH" >&2
    exit 2
  fi
fi

# 현재 시간 기록
date +%s > "$CACHE_FILE"
exit 0
