document.addEventListener("DOMContentLoaded", function() {
  const form = document.querySelector("form.js-plan-item");

  if (form) {
    const allDay =
      form.querySelector(
        "input[name='plan_item[all_day]'][type='checkbox']"
      );

    function toggleInputFields() {
      form.querySelectorAll(".js-date-and-time").forEach(function(div) {
        div.classList.toggle("d-none", allDay.checked);
        div.querySelector("input")
          .toggleAttribute("required", !allDay.checked);
      });

      form.querySelectorAll(".js-date-picker").forEach(function(div) {
        div.classList.toggle("d-none", !allDay.checked)
        div.querySelector("input")
          .toggleAttribute("required", allDay.checked);
      })
    }

    toggleInputFields();

    allDay.addEventListener("change", function() {
      toggleInputFields();
    });
  }
});
