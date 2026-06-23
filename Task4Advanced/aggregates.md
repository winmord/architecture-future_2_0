# Агрегаты системы

## Medical Context

### Patient Aggregate
- **Корень агрегата:** Patient
- **Границы:** Профиль пациента, контактные данные, страховая информация
- **Инварианты:** Один пациент не может быть зарегистрирован дважды (уникальный идентификатор)
- **Ключи:** PatientId (UUID)
- **События:** PatientRegistered, PatientUpdated, PatientDeactivated

### MedicalRecord Aggregate
- **Корень агрегата:** MedicalRecord
- **Границы:** История болезни, диагнозы, результаты анализов, записи врачей
- **Инварианты:** Медицинская карта принадлежит только одному пациенту. Запись не может быть изменена после подтверждения
- **Ключи:** MedicalRecordId (UUID), PatientId (Foreign Key)
- **События:** DiagnosisAdded, MedicalRecordCreated, PrescriptionAdded

### Consultation Aggregate
- **Корень агрегата:** Consultation
- **Границы:** Приём, назначения, рекомендации, статус консультации
- **Инварианты:** Консультация не может быть запланирована на прошедшее время. Нельзя отменить завершённую консультацию
- **Ключи:** ConsultationId (UUID), PatientId, DoctorId
- **События:** ConsultationScheduled, ConsultationCompleted, ConsultationCancelled

### Prescription Aggregate
- **Корень агрегата:** Prescription
- **Границы:** Назначение лекарств, дозировка, срок действия
- **Инварианты:** Дозировка должна быть положительной. Срок действия не может быть меньше даты выписки
- **Ключи:** PrescriptionId (UUID), ConsultationId, PatientId
- **События:** PrescriptionIssued, PrescriptionFulfilled, PrescriptionExpired

### DiagnosticStudy Aggregate
- **Корень агрегата:** DiagnosticStudy
- **Границы:** Результаты диагностических исследований, снимки, заключения
- **Инварианты:** Исследование должно быть привязано к конкретному пациенту. Результаты нельзя удалить после сохранения
- **Ключи:** DiagnosticStudyId (UUID), PatientId
- **События:** DiagnosticStudyRequested, DiagnosticStudyCompleted, DiagnosticStudyReviewed

## Fintech Context

### Account Aggregate
- **Корень агрегата:** Account
- **Границы:** Банковский счёт, баланс, валюта, статус
- **Инварианты:** Баланс не может быть отрицательным (для некоторых типов счетов). Аккаунт не может быть закрыт с положительным балансом
- **Ключи:** AccountId (UUID), ClientId
- **События:** AccountOpened, AccountClosed, BalanceChanged

### Transaction Aggregate
- **Корень агрегата:** Transaction
- **Границы:** Платёж, перевод, проводка
- **Инварианты:** Сумма транзакции должна быть положительной. Транзакция не может быть изменена после подтверждения
- **Ключи:** TransactionId (UUID), AccountId
- **События:** TransactionInitiated, TransactionCompleted, TransactionFailed

### CreditAggregate
- **Корень агрегата:** Credit
- **Границы:** Кредитный договор, график платежей, сумма, процентная ставка
- **Инварианты:** Сумма кредита не может превышать лимит. График платежей должен быть согласован
- **Ключи:** CreditId (UUID), ClientId
- **События:** CreditIssued, CreditPaymentMade, CreditDefaulted

## AI Context

### AIDiagnosis Aggregate
- **Корень агрегата:** AIDiagnosis
- **Границы:** Результат ИИ-диагностики, точность, рекомендации
- **Инварианты:** Диагноз должен быть подтверждён врачом для включения в медицинскую карту
- **Ключи:** AIDiagnosisId (UUID), PatientId, DiagnosticStudyId
- **События:** DiagnosisPredicted, DiagnosisConfirmed

## Analytics Context

### AnalyticsReport Aggregate
- **Корень агрегата:** AnalyticsReport
- **Границы:** Отчёт, дашборд, агрегации
- **Инварианты:** Отчёт должен быть построен на актуальных данных. Витрины обновляются в near-real-time
- **Ключи:** ReportId (UUID), ReportType, Period
- **События:** ReportGenerated, ViewUpdated

## Inventory Context

### InventoryItem Aggregate
- **Корень агрегата:** InventoryItem
- **Границы:** Лекарство, оборудование, количество, срок годности
- **Инварианты:** Количество не может быть отрицательным. Срок годности не может быть просрочен
- **Ключи:** InventoryItemId (UUID), SKU
- **События:** StockUpdated, StockReserved, StockDepleted