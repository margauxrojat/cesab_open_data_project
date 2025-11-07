# Render le script README à la racine du projet

rmarkdown::render(input = "README.rmd", output_file = "README.md")

# Render le script JoliesFeuilles.Rmd
dir.create(here("results"))
rmarkdown::render(input = here("code", "JoliesFeuilles.rmd"),
                  output_file = here("results", "README.md"))
