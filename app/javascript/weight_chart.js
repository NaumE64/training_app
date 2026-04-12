// app/javascript/weight_chart.js
document.addEventListener("DOMContentLoaded", function() {
  const container = document.querySelector('[data-controller="weight-chart"]')
  if (!container) return
  
  const workoutIds = JSON.parse(container.dataset.workoutIds || "[]")
  
  setTimeout(function() {
    const canvas = document.querySelector("#weight-chart canvas")
    if (!canvas) return
    
    canvas.addEventListener("click", function(event) {
      const chartObj = Chartkick.charts["weight-chart"]
      if (!chartObj) return
      
      const chart = chartObj.getChartObject()
      const rect = canvas.getBoundingClientRect()
      const clickX = event.clientX - rect.left
      const clickY = event.clientY - rect.top
      
      const labels = chart.data.labels
      const points = chart.data.datasets[0].data
      const xAxis = chart.scales.x
      const yAxis = chart.scales.y
      
      let minDistance = 50
      let clickedIndex = -1
      
      points.forEach((yValue, index) => {
        const xValue = labels[index]
        const pointX = xAxis.getPixelForValue(xValue)
        const pointY = yAxis.getPixelForValue(yValue)
        const distance = Math.hypot(clickX - pointX, clickY - pointY)
        
        if (distance < minDistance) {
          minDistance = distance
          clickedIndex = index
        }
      })
      
      if (clickedIndex !== -1 && minDistance < 50) {
        const workoutId = workoutIds[clickedIndex]
        if (workoutId) {
          window.location.href = `/workouts/${workoutId}`
        }
      }
    })
  }, 1000)
})