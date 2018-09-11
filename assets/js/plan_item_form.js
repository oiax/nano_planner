import $ from "jquery";

$(() => {
  const form = $("form.plan-item")

  if (form.length > 0) {
    const checkBox =
      form.find("input[name='plan_item[all_day]'][type='checkbox']");

    const toggleInputFields = () => {
      const allDay = checkBox.prop("checked");
      const div1 = form.find(".js-date-and-time");
      const div2 = form.find(".js-date-picker");

      if (allDay) {
        div1.hide().find("input").removeAttr("required");
        div2.show().find("input").attr("required", true);
      }
      else {
        div1.show().find("input").attr("required", true);
        div2.hide().find("input").removeAttr("required");
      }
    };

    toggleInputFields();

    checkBox.on("change", toggleInputFields);
  }
});
