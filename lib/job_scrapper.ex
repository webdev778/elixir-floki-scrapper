defmodule JobScrapper do
   def job_detail() do
    case HTTPoison.get(
           "https://www.ziprecruiter.com/jobs/metaoption-llc-a6a457c5/devops-automation-engineer-84ef9ba1"
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        %{
          title: Floki.find(body, ".job_description .job_header h1.job_title") |> Floki.text(),
          location: Floki.find(body, ".job_description .job_header .location_and_company .t_company_name a") |> Floki.text(),
          company: Floki.find(body, ".job_description .job_header .location_and_company .location_text span") |> Floki.text(),
          description: Floki.find(body, ".job_description .job_content .jobDescriptionSection div") |> Floki.text()
        }
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end
end
