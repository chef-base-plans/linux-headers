plan_name = input("plan_name", value: "core/linux-headers")

plan_path = command("hab pkg path #{plan_name}").stdout.strip
plan_dir = input("plan_dir", value: "/include/")
target_dir = "#{plan_path}#{plan_dir}"

plan_files = input("plan_files")

plan_files.each do | file |
  describe file("#{target_dir}#{file}") do
    it("#{file} should exist") { should exist }
  end
end
