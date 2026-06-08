#!/bin/bash

LOG_FILE="system_health.log"
THRESHOLD=80

echo "--- System Health Check: $(date) ---" | tee -a "$LOG_FILE"

MEM_USAGE=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}')
if [ "$MEM_USAGE" -gt "$THRESHOLD" ]; then
    echo "⚠️  ALERT: Memory usage is critically high: ${MEM_USAGE}%" | tee -a "$LOG_FILE"
else
    echo "✅ Memory usage is normal: ${MEM_USAGE}%" | tee -a "$LOG_FILE"
fi

CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print $2 + $4}')
CPU_INT=${CPU_USAGE%.*}

if [ "$CPU_INT" -gt "$THRESHOLD" ]; then
    echo "⚠️  ALERT: CPU usage is critically high: ${CPU_INT}%" | tee -a "$LOG_FILE"
else
    echo "✅ CPU usage is normal: ${CPU_INT}%" | tee -a "$LOG_FILE"
fi

DISK_USAGE=$(df -h / | awk '/\// {print $(NF-1)}' | sed 's/%//')
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
    echo "⚠️  ALERT: Disk space is critically low. Usage: ${DISK_USAGE}%" | tee -a "$LOG_FILE"
else
    echo "✅ Disk space is normal: ${DISK_USAGE}%" | tee -a "$LOG_FILE"
fi

PROCESS_COUNT=$(ps -e | wc -l)
echo "ℹ️  Total running processes: $PROCESS_COUNT" | tee -a "$LOG_FILE"
echo "--------------------------------------" | tee -a "$LOG_FILE"