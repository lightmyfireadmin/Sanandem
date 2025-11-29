<script lang="ts">
	import { enhance } from '$app/forms';
	import type { PageData } from './$types';
	import {
		Table, TableBody, TableBodyCell, TableBodyRow, TableHead, TableHeadCell,
		Button, Label, Input, Select, Range, Card
	} from 'flowbite-svelte';
	import { onMount } from 'svelte';
	import * as echarts from 'echarts';

	let { data } = $props();

	let genderOptions = [
		{ value: 'male', name: 'Male' },
		{ value: 'female', name: 'Female' },
		{ value: 'other', name: 'Other' }
	];

	// Prepare chart data
    let sideEffectCounts: Record<string, number> = {};
	let severityByAge: any[] = [];

    data.reports.forEach((r: any) => {
        sideEffectCounts[r.sideEffect] = (sideEffectCounts[r.sideEffect] || 0) + 1;
		severityByAge.push([r.age, r.severity]);
    });
    let pieData = Object.entries(sideEffectCounts).map(([name, value]) => ({ name, value }));

	let chartDomPie: HTMLDivElement;
	let chartDomScatter: HTMLDivElement;

	onMount(() => {
        const charts: echarts.ECharts[] = [];

		if (chartDomPie) {
			const myChart = echarts.init(chartDomPie);
            charts.push(myChart);
			const option = {
				title: {
					text: 'Side Effects Distribution',
					left: 'center'
				},
				tooltip: {
					trigger: 'item'
				},
				legend: {
					orient: 'vertical',
					left: 'left'
				},
				series: [
					{
						name: 'Side Effects',
						type: 'pie',
						radius: '50%',
						data: pieData,
						emphasis: {
							itemStyle: {
								shadowBlur: 10,
								shadowOffsetX: 0,
								shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						}
					}
				]
			};
			myChart.setOption(option);
		}

		if (chartDomScatter) {
			const myChart = echarts.init(chartDomScatter);
            charts.push(myChart);
			const option = {
				title: {
					text: 'Severity vs Age',
					left: 'center'
				},
				xAxis: {
					name: 'Age',
					scale: true
				},
				yAxis: {
					name: 'Severity',
					scale: true
				},
				tooltip: {
					trigger: 'item',
					formatter: function (params: any) {
						return `Age: ${params.data[0]}<br/>Severity: ${params.data[1]}`;
					}
				},
				series: [
					{
						type: 'scatter',
						data: severityByAge,
						symbolSize: 10
					}
				]
			};
			myChart.setOption(option);
		}

        const handleResize = () => charts.forEach(c => c.resize());
        window.addEventListener('resize', handleResize);

        return () => {
            window.removeEventListener('resize', handleResize);
            charts.forEach(c => c.dispose());
        };
	});
</script>

<div class="p-8 space-y-8">
	<h1 class="text-3xl font-bold dark:text-white">Admin Dashboard</h1>

	<div class="grid grid-cols-1 md:grid-cols-2 gap-8">
		<Card size="xl">
			<div bind:this={chartDomPie} style="width: 100%; height: 400px;"></div>
		</Card>
		<Card size="xl">
			<div bind:this={chartDomScatter} style="width: 100%; height: 400px;"></div>
		</Card>
	</div>

	<div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
		<Card class="w-full max-w-none">
			<h2 class="text-xl font-semibold mb-4 dark:text-white">Add Medication Report</h2>
			<form method="POST" action="?/create" use:enhance class="space-y-4">
				<div>
					<Label for="medicationName" class="mb-2">Medication Name</Label>
					<Input id="medicationName" name="medicationName" placeholder="e.g. Aspirin" required />
				</div>

				<div>
					<Label for="sideEffect" class="mb-2">Side Effect</Label>
					<Input id="sideEffect" name="sideEffect" placeholder="e.g. Headache" required />
				</div>

				<div class="grid grid-cols-2 gap-4">
					<div>
						<Label for="age" class="mb-2">Age</Label>
						<Input type="number" id="age" name="age" required />
					</div>
					<div>
						<Label for="gender" class="mb-2">Gender</Label>
						<Select id="gender" items={genderOptions} name="gender" required placeholder="Select gender" />
					</div>
				</div>

				<div>
					<Label for="severity" class="mb-2">Severity (1-10)</Label>
					<Range id="severity" name="severity" min="1" max="10" value="5" />
					<div class="flex justify-between text-xs text-gray-500">
						<span>Mild</span>
						<span>Severe</span>
					</div>
				</div>

				<Button type="submit" class="w-full">Submit Report</Button>
			</form>
		</Card>

		<div class="overflow-x-auto">
			<h2 class="text-xl font-semibold mb-4 dark:text-white">Recent Reports</h2>
			<Table striped={true}>
				<TableHead>
					<TableHeadCell>Medication</TableHeadCell>
					<TableHeadCell>Side Effect</TableHeadCell>
					<TableHeadCell>Severity</TableHeadCell>
					<TableHeadCell>Age</TableHeadCell>
					<TableHeadCell>Date</TableHeadCell>
				</TableHead>
				<TableBody>
					{#each data.reports.slice(0, 10) as report}
						<TableBodyRow>
							<TableBodyCell>{report.medicationName}</TableBodyCell>
							<TableBodyCell>{report.sideEffect}</TableBodyCell>
							<TableBodyCell>{report.severity}</TableBodyCell>
							<TableBodyCell>{report.age}</TableBodyCell>
							<TableBodyCell>{new Date(report.createdAt).toLocaleDateString()}</TableBodyCell>
						</TableBodyRow>
					{/each}
				</TableBody>
			</Table>
		</div>
	</div>
</div>
