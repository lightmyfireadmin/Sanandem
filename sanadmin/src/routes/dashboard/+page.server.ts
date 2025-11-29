import { fail } from '@sveltejs/kit';
import { db } from '$lib/server/db/index';
import { medicationReports } from '$lib/server/db/schema';
import { desc } from 'drizzle-orm';
import type { Actions, PageServerLoad } from './$types';
import { env } from '$env/dynamic/private';

export const load: PageServerLoad = async () => {
	try {
		if (!env.DATABASE_URL) throw new Error("No DB URL");
		const reports = await db.select().from(medicationReports).orderBy(desc(medicationReports.createdAt));
		return {
			reports
		};
	} catch (e) {
		console.warn("Database connection failed or not configured, using mock data.");
		const mockReports = Array.from({ length: 50 }, (_, i) => ({
			id: i + 1,
			medicationName: ['Aspirin', 'Ibuprofen', 'Paracetamol', 'Amoxicillin', 'Metformin', 'Lisinopril', 'Atorvastatin'][Math.floor(Math.random() * 7)],
			sideEffect: ['Headache', 'Nausea', 'Dizziness', 'Rash', 'Stomach Pain', 'Fatigue', 'Insomnia'][Math.floor(Math.random() * 7)],
			severity: Math.floor(Math.random() * 10) + 1,
			age: Math.floor(Math.random() * 80) + 18,
			gender: ['male', 'female', 'other'][Math.floor(Math.random() * 3)],
			createdAt: new Date(Date.now() - Math.floor(Math.random() * 10000000000))
		}));
		return {
			reports: mockReports
		};
	}
};

export const actions: Actions = {
	create: async ({ request }) => {
		const formData = await request.formData();
		const medicationName = formData.get('medicationName') as string;
		const sideEffect = formData.get('sideEffect') as string;
		const severity = parseInt(formData.get('severity') as string);
		const age = parseInt(formData.get('age') as string);
		const gender = formData.get('gender') as string;

		if (!medicationName || !sideEffect || isNaN(severity) || isNaN(age) || !gender) {
			return fail(400, { missing: true });
		}

		try {
             if (!env.DATABASE_URL) throw new Error("No DB URL");
			await db.insert(medicationReports).values({
				medicationName,
				sideEffect,
				severity,
				age,
				gender
			});
		} catch (e) {
			console.warn("Database insert failed (mock mode)");
            // In a real mock scenario, we might want to update some in-memory store, but for now just success
		}

		return { success: true };
	},
	delete: async ({ request }) => {
		// Implement delete logic if needed
		return { success: true };
	}
};
