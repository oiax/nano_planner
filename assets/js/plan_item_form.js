import $ from "jquery";

$(() => {
  const form = $("form.js-plan-item")

  if (form.length > 0) {
    const checkBox =
      form.find("input[name='plan_item[all_day]'][type='checkbox']");

    const toggleInputFields = () => {
      const allDay = checkBox.prop("checked");
      form.find(".js-date-and-time").toggle(!allDay);
      form.find(".js-date-picker").toggle(allDay);
    })

    toggleInputFields();

    checkBox.on("change", toggleInputFields)
  }
});
