# Каталог доменных событий

## Medical Context

### PatientRegistered
- **Источник:** Patient Management
- **Семантика:** Новый пациент зарегистрирован в системе
- **Подписчики:** Analytics (для статистики), Fintech (для открытия счёта), AI (для прогнозов)
- **Контракт:**
```json
{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "patientId": "uuid",
  "name": "string",
  "dateOfBirth": "date",
  "gender": "string",
  "insuranceNumber": "string"
}
```

### DiagnosisAdded
- **Источник:** Medical Records
- **Семантика:** Новый диагноз добавлен в медицинскую карту пациента
- **Подписчики:** AI (для проверки), Analytics (для статистики), Fintech (для страховых случаев)
- **Контракт:**

```json
{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "patientId": "uuid",
  "medicalRecordId": "uuid",
  "diagnosis": "string",
  "diagnosisCode": "string (ICD-10)",
  "doctorId": "uuid",
  "diagnosisDate": "date"
}
```

### PrescriptionIssued
- **Источник:** Prescriptions
- **Семантика:** Врач выписал рецепт для пациента
- **Подписчики:** Inventory (для резервирования лекарств), Analytics (для статистики), Fintech (для оплаты)
- **Контракт:**

```json
{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "prescriptionId": "uuid",
  "patientId": "uuid",
  "doctorId": "uuid",
  "medications": [
    {
      "name": "string",
      "dosage": "string",
      "quantity": "integer"
    }
  ],
  "validUntil": "date"
}
```

### ConsultationCompleted
- **Источник:** Consultations
- **Семантика:** Консультация с врачом завершена
- **Подписчики:** Analytics (для статистики), Fintech (для выставления счёта)
- **Контракт:**

```json
{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "consultationId": "uuid",
  "patientId": "uuid",
  "doctorId": "uuid",
  "type": "string (online/offline)",
  "duration": "integer (minutes)",
  "conclusion": "string"
}
```

### DiagnosticStudyCompleted
- **Источник:** Diagnostics
- **Семантика:** Диагностическое исследование завершено
- **Подписчики:** AI (для анализа), Analytics (для статистики), Medical Records (для сохранения результатов)
- **Контракт:**

```json
{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "studyId": "uuid",
  "patientId": "uuid",
  "doctorId": "uuid",
  "studyType": "string (MRI/CT/Ultrasound/Lab)",
  "results": "object",
  "files": ["s3-urls"]
}
```

## Fintech Context
### AccountOpened

- **Источник:** Account Management
- **Семантика:** Открыт новый банковский счёт (в том числе для пациента)
- **Подписчики:** Analytics (для статистики), Medical (для отображения услуг)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "accountId": "uuid",
  "clientId": "uuid (может быть PatientId)",
  "accountType": "string (current/savings/credit)",
  "currency": "string (RUB/USD/EUR)",
  "initialBalance": "decimal"
}
```
### PaymentProcessed

- **Источник:** Payment Processing
- **Семантика:** Платёж обработан успешно
- **Подписчики:** Analytics (для отчётности), Medical (для оплаты услуг), Inventory (для подтверждения поставок)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "paymentId": "uuid",
  "accountId": "uuid",
  "amount": "decimal",
  "currency": "string",
  "paymentType": "string (card/transfer/auto)",
  "status": "string (success/failed/pending)",
  "reference": "string"
}
```
### CreditIssued

- **Источник:** Credit Management
- **Семантика:** Оформлен кредитный договор
- **Подписчики:** Analytics (для статистики), Risk Assessment (для мониторинга)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "creditId": "uuid",
  "clientId": "uuid",
  "amount": "decimal",
  "term": "integer (months)",
  "interestRate": "decimal",
  "purpose": "string",
  "approvalStatus": "string (approved/rejected)"
}
```
### TransactionCompleted

- **Источник:** Transaction Management
- **Семантика:** Финансовая транзакция успешно завершена
- **Подписчики:** Analytics (для отчётности), Risk Assessment (для мониторинга)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "transactionId": "uuid",
  "accountId": "uuid",
  "amount": "decimal",
  "currency": "string",
  "transactionType": "string (debit/credit/transfer)",
  "counterparty": "string",
  "status": "string (completed/failed)"
}
```
### RiskAssessed

- **Источник:** Risk Assessment
- **Семантика:** Проведена оценка рисков по клиенту или транзакции
- **Подписчики:** Credit Management (для принятия решения), Analytics (для статистики)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "assessmentId": "uuid",
  "clientId": "uuid",
  "score": "integer (0-100)",
  "riskLevel": "string (low/medium/high)",
  "factors": ["string"],
  "recommendation": "string"
}
```
## AI Context
### DiagnosisPredicted

- **Источник:** AI Diagnostics
- **Семантика:** ИИ выдал прогноз по диагностическому исследованию
- **Подписчики:** Medical Records (для сохранения рекомендаций), Analytics (для оценки точности)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "predictionId": "uuid",
  "studyId": "uuid",
  "patientId": "uuid",
  "predictedDiagnosis": "string",
  "confidence": "float (0.0-1.0)",
  "recommendations": ["string"],
  "aiModelVersion": "string"
}
```
### TreatmentRecommended

- **Источник:** AI Recommendation
- **Семантика:** ИИ предложил рекомендацию по лечению на основе данных
- **Подписчики:** Consultations (для врачей), Medical Records (для сохранения)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "recommendationId": "uuid",
  "patientId": "uuid",
  "condition": "string",
  "recommendedTreatment": "string",
  "alternativeTreatments": ["string"],
  "confidence": "float"
}
```
### AnomalyDetected

- **Источник:** AI Monitoring
- **Семантика:** ИИ обнаружил аномалию в медицинских данных пациента
- **Подписчики:** Medical Records (для оповещения врачей), Analytics (для статистики)
- **Контракт:**

```json
{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "patientId": "uuid",
  "anomalyType": "string",
  "description": "string",
  "severity": "string (low/medium/high)",
  "dataPoint": "object",
  "recommendation": "string"
}
```
## Analytics Context
### ReportGenerated

- **Источник:** Analytics
- **Семантика:** Сформирован аналитический отчёт
- **Подписчики:** Self-Service Portal (для отображения), External Systems (для регуляторов)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "reportId": "uuid",
  "reportType": "string (financial/medical/operational)",
  "period": "string",
  "generatedBy": "string",
  "dataUrl": "s3-url",
  "format": "string (pdf/excel/json)"
}
```
### DashboardUpdated

- **Источник:** Analytics
- **Семантика:** Обновлён дашборд с актуальными данными
- **Подписчики:** Self-Service Portal (для отображения)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "dashboardId": "uuid",
  "dashboardType": "string",
  "dataVersion": "string",
  "metrics": "object",
  "updateTime": "iso8601"
}
```
## Inventory Context
### StockUpdated

- **Источник:** Inventory Management
- **Семантика:** Обновлены остатки на складе
- **Подписчики:** Analytics (для отчётности), Fintech (для оплаты поставок)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "itemId": "uuid",
  "sku": "string",
  "name": "string",
  "quantity": "integer",
  "location": "string",
  "updateType": "string (add/remove/reserve)",
  "newQuantity": "integer"
}
```
### StockDepleted

- **Источник:** Inventory Management
- **Семантика:** Лекарство или материал закончился на складе
- **Подписчики:** Medical (для оповещения врачей), Analytics (для прогнозирования)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "itemId": "uuid",
  "sku": "string",
  "name": "string",
  "criticalLevel": "boolean",
  "estimatedRestockDate": "date",
  "alertLevel": "string (warning/critical)"
}
```
### StockReserved

- **Источник:** Inventory Management
- **Семантика:** Зарезервирован товар для конкретного заказа или рецепта
- **Подписчики:** Medical (для подтверждения выписки), Analytics (для статистики)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "reservationId": "uuid",
  "itemId": "uuid",
  "sku": "string",
  "name": "string",
  "quantity": "integer",
  "referenceId": "uuid (PrescriptionId или OrderId)",
  "expiresAt": "iso8601"
}
```
## Integration Context
### LegacyDataSynced

- **Источник:** Anti-Corruption Layer
- **Семантика:** Данные синхронизированы с легаси-системой
- **Подписчики:** Analytics (для проверки целостности), Monitoring (для логирования)
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "source": "string (DWH/ESB)",
  "entityType": "string",
  "entityId": "string",
  "syncStatus": "string (success/failed/partial)",
  "recordsProcessed": "integer",
  "errors": ["string"]
}
```
### ExternalEventReceived

- **Источник:** Event Gateway
- **Семантика:** Получено событие от внешней системы (фармацевтика, ИИ-сервисы, регуляторы)
- **Подписчики:** Соответствующие домены
- **Контракт:**

```json

{
  "eventId": "uuid",
  "timestamp": "iso8601",
  "source": "string",
  "eventType": "string",
  "data": "object",
  "correlationId": "string"
}
```