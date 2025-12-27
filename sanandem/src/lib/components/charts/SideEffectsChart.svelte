<script lang="ts">
  import * as d3 from 'd3';
  import { onMount } from 'svelte';

  export let data: any[] = [];

  let svg: any;
  let width = 600;
  let height = 400;

  onMount(() => {
    const simulation = d3.forceSimulation(data as any)
        .force("charge", d3.forceManyBody().strength(5))
        .force("center", d3.forceCenter(width / 2, height / 2))
        .force("collision", d3.forceCollide().radius((d: any) => d.value + 5));

    const svgEl = d3.select(svg);

    const color = d3.scaleOrdinal(d3.schemeCategory10);

    const nodes = svgEl.selectAll("circle")
        .data(data)
        .join("circle")
        .attr("r", d => d.value)
        .attr("fill", d => color(d.group.toString()))
        .attr("opacity", 0.8)
        .attr("stroke", "#fff")
        .attr("stroke-width", 2);

    const labels = svgEl.selectAll("text")
        .data(data)
        .join("text")
        .text(d => d.id)
        .attr("text-anchor", "middle")
        .attr("dy", ".35em")
        .style("font-size", "12px")
        .style("font-weight", "bold")
        .style("fill", "#333")
        .style("pointer-events", "none");

    simulation.on("tick", () => {
        nodes
            .attr("cx", d => d.x)
            .attr("cy", d => d.y);

        labels
            .attr("x", d => d.x)
            .attr("y", d => d.y);
    });
  });
</script>

<div class="border rounded-lg p-4 bg-white shadow flex justify-center w-full">
    <svg bind:this={svg} viewBox={`0 0 ${width} ${height}`} class="w-full h-auto max-h-[400px]"></svg>
</div>
