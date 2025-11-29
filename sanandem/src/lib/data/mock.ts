export const mockMedicationReports = Array.from({ length: 100 }, (_, i) => ({
    id: i,
    medicationName: ['Aspirin', 'Ibuprofen', 'Paracetamol', 'Lisino', 'Metformin'][Math.floor(Math.random() * 5)],
    sideEffect: ['Headache', 'Nausea', 'Dizziness', 'Fatigue', 'Rash'][Math.floor(Math.random() * 5)],
    severity: Math.floor(Math.random() * 10) + 1,
    age: Math.floor(Math.random() * 80) + 18,
    gender: ['male', 'female', 'other'][Math.floor(Math.random() * 3)],
    createdAt: new Date().toISOString()
}));

export const sideEffectStats = [
    { name: 'Headache', value: 30 },
    { name: 'Nausea', value: 25 },
    { name: 'Dizziness', value: 20 },
    { name: 'Fatigue', value: 15 },
    { name: 'Rash', value: 10 }
];

export const severityByMed = [
    { name: 'Aspirin', value: 3.5 },
    { name: 'Ibuprofen', value: 4.2 },
    { name: 'Paracetamol', value: 2.1 },
    { name: 'Lisino', value: 5.0 },
    { name: 'Metformin', value: 4.8 }
];
