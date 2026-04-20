---
title: "Final Project Grading Rubrics"
subtitle: "EFB 645/496: Introduction to R and Reproducible Research — Spring 2026"
output:
  html_document:
    theme: cosmo
    toc: true
    toc_depth: 2
    toc_float:
      collapsed: false
      smooth_scroll: true
---

Each final project is scored on four categories, OK (1) / Good (2) / Excellent (3), for a total of **12 points**. Pick the section below that matches your chosen project format.

---

## Option A: R Package

- Upload a "Source Bundle" of the package (`> Build > Build Source Package`) to Blackboard.  This will be an `tar.gz` file another person can install.  

- Aim for the function to contain at least three functions (with at least 2 arguments in each function).  

- Provide a detailed description of the package inside of the `DESCRIPTION` file.   You can check that it works with: `help(package = "mypackage")`.


| Category | OK (1) | Good (2) | Excellent (3) |
|---|---|---|---|
| **Purpose & scope** | Unclear what the package does or why it exists. | Purpose stated; scope unclear or too broad. | Clear, focused purpose. |
| **Custom functions (≥3 required)** | Fewer than three functions, or trivial wrappers. | Three functions present but uneven in functionality. | Three or more useful functions with sensible arguments and names. |
| **Documentation** | Missing or incomplete roxygen2 comments; no README. | Roxygen on each function; README present but sparse. | Roxygen on each function with a working example; README explains purpose and how to install/use. |
| **Package builds & runs** | Package does not install or load. | Installs with minor fixes; functions work. | Installs cleanly; functions work as documented. |

**Total: __ / 12**


---

## Option B: Shiny App

- Upload an `.R` or `.Rmd` that runs a working Shiny App to Blackboard.

- Provide a document -- or, preferred, embed into a Markdown that includes the Shiny App -- describing the context, purpose, data behind the app, focusing on why it was helpful / useful to create an interactive tool.   

| Category | OK (1) | Good (2) | Excellent (3) |
|---|---|---|---|
| **Purpose & problem** | Unclear purpose or audience. | Purpose stated but motivation thin. | Clear problem and clear reason for an interactive tool. |
| **UI design** | Cluttered, unclear controls, no labels. | Functional; layout could be improved. | Clean layout, labeled inputs, appropriate widget choices. |
| **App works as intended** | App crashes or inputs don't update outputs correctly. | Works; minor glitches or slow spots. | Runs smoothly; all inputs produce the expected outputs. |
| **Documentation & reproducibility** | No in-app explanation or README; won't run elsewhere. | Some in-app guidance or minimal README; runs with minor tweaks. | In-app instructions plus README; instructor can `runApp()` without edits. |

**Total: __ / 12**

> **Notes:**  Upload  (or email to professors) a "Source Bundle" of the package (`> Build > Build Source Package`) to Blackboard.  

---

## Option C: Research Report

- Upload a well-documented and organized reproducible report to Blackboard, both an Rmd file and a compiled pdf.  

- Make it clear what the purpose of the report is: is it moving research forward, it is exploratory, is it a summary of advanced R tools for data analysis.   

- Provide a clear scientific motivation for the inquiry.  

| Category | OK (1) | Good (2) | Excellent (3) |
|---|---|---|---|
| **Background & data** | Little description of the scientific question; no description of how data were collected. | Some background and data description; missing references or reproducibility details. | Thorough introduction with references; data collection described in enough detail for an outside group to reproduce. |
| **Data summary** | No summary, or summary missing key elements. | Summary present but incomplete. | Thorough summary: dimensions, meaning of entries, missing-data reasoning. |
| **Analysis & R code shown** | Methods not described; no R code visible in the report, or code is inefficient / non-reproducible. | Methods described; some R code shown in the analysis section; could be tighter. | Methods fully described; efficient, understandable R code embedded in the analysis section generates all results reproducibly. |
| **Results, discussion & conclusions** | Incomplete results; no figures or tables; no discussion or inaccurate conclusions. | Good results and some discussion of implications or caveats. | Thorough results with well-chosen figures and tables; thorough discussion of implications, caveats, and future work; accurate conclusions. |

**Total: __ / 12**
