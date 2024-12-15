CREATE TABLE Users (
    UserID TEXT PRIMARY KEY,
    Role TEXT CHECK (Role IN ('Admin', 'Employee')) NOT NULL,
    Department TEXT,
    JobTitle TEXT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    SurName TEXT,
    Status TEXT CHECK (Status IN ('Active', 'Terminated')) DEFAULT 'Active',
    DateOfBirth TEXT NOT NULL,
    Gender TEXT CHECK (Gender IN ('Male', 'Female')),
    Email TEXT UNIQUE NOT NULL,
    AddressLine1 TEXT,
    AddressLine2 TEXT,
    City TEXT,
    State TEXT,
    Zip TEXT,
    Picture BLOB,
    Password TEXT NOT NULL
);

CREATE TABLE Payroll (
    PayrollID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID TEXT NOT NULL,
    PayType TEXT CHECK (PayType IN ('Salary', 'Hourly')) NOT NULL,
    HourlyRate REAL NOT NULL,
    FederalTax REAL NOT NULL DEFAULT 0.0765,
    StateTax REAL NOT NULL DEFAULT 0.0315,
    SocialSecurity REAL NOT NULL DEFAULT 0.062,
    Medicare REAL NOT NULL DEFAULT 0.0145,
    OtherDeductions REAL NOT NULL DEFAULT 0.0,
    Dependents INTEGER NOT NULL DEFAULT 0,
    MedicalCoverage TEXT CHECK (MedicalCoverage IN ('Single', 'Family')) NOT NULL,
    PTO REAL NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TimeEntries (
    EntryID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID TEXT NOT NULL,
    PayPeriodStart DATE NOT NULL,
    RegularHours REAL NOT NULL DEFAULT 0.0,
    OvertimeHours REAL NOT NULL DEFAULT 0.0,
    PTOHours REAL NOT NULL DEFAULT 0.0,
    Locked BOOLEAN DEFAULT 0,
    HourlyRate REAL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PaySlip (
    PaySlipID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID TEXT NOT NULL,
    PayrollID INTEGER NOT NULL,
    TimeEntryID INTEGER NOT NULL,
    PayPeriodStart DATE NOT NULL,
    PayPeriodEnd DATE NOT NULL,
    TotalRegularHours REAL NOT NULL,
    TotalOvertimeHours REAL NOT NULL,
    TotalPTOHours REAL NOT NULL,
    GrossPay REAL NOT NULL,
    MedicalDeduction REAL NOT NULL,
    FederalTax REAL NOT NULL,
    StateTax REAL NOT NULL,
    SocialSecurity REAL NOT NULL,
    Medicare REAL NOT NULL,
    DependentStipend REAL NOT NULL,
    OtherDeductions REAL NOT NULL DEFAULT 0.0,
    NetPay REAL NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PayrollID) REFERENCES Payroll(PayrollID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (TimeEntryID) REFERENCES TimeEntries(EntryID)
        ON DELETE CASCADE ON UPDATE CASCADE
);



