import $ from "jquery";

$(() => {
  const form = $("form.plan-item")

  if (form.length > 0) {
    const checkBox = $("#plan_item_all_day");

    const toggleInputFields = () => {
      const allDay = checkBox.prop("checked");
      form.find(".js-date-and-time").toggle(!allDay);
      form.find(".js-date-picker").toggle(allDay);
    }

    toggleInputFields();

    checkBox.on("change", toggleInputFields)
  }
});
