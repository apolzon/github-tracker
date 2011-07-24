describe("Project Type", function() {
  loadFixtures("project_type.html");
  $("#project").updateFormByType();


  describe("when Pivotal is chosen as the type", function() {
    beforeEach(function() {
      $("#project_type").val("pivotal_project").change();
    });

    it("loads the Pivotal form", function() {
      expect(a).toBeTruthy();
    });
  });
});
