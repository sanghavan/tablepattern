# Table View Data Source Design Pattern

[![](https://img.shields.io/badge/contact-@thematerik-blue.svg?style=flat-square)](http://twitter.com/thematerik)

## Install

```
pod 'TableViewDataSourceDesignPattern/ObjC', :git => 'https://github.com/materik/tableviewdatasourcedesignpattern.git'
```

## Demo

Checkout the `xcworkspace` in `ObjCDemo` to get an idea of how to implement the
pattern.

## Pattern

### TableViewController

  - *Need to be subclassed*
  - `dataSource`
    - Create an instance of a subclassed `TableViewDataSource`

### TableViewDataSource

  - *Need to be subclassed*
  - `numberOfSections`
    - Return the number of sections that your table view contains.
  - `- loadDataOnCompletion:`
    - Fetch your data in this method and store it in a local variable.
    - Call completion when your done.
  - `- loadPaginatedDataInPage:withLimit:onCompletion:`
    - Only called if you have set `enablePagination` to true.
    - Need to set `paginationLimit` in order for it to work.
    - Do the same as `loadDataOnCompletion`, the only exception is that the
      completion block takes a boolean which indicates if there is more data to
      load or not.
  - `- createDataSourceSectionInSection:`
    - Create an instance of a subclassed `TableViewDataSourceSection`, given the data
      that has been loaded in either `loadData` method, for that specific section.

### TableViewDataSourceSection

  - *Need to be subclassed*
  - `objectClass`
    - What is the class if the `id` object stored by the section.
  - `- numberOfRows`
    - Return the number of rows that this section should contain.
  - `- createDataSourceRowAtRow:`
    - Create an instance of a subclassed `TableViewDataSourceRow`, given the
      object stored by the section, for that specific row.

### TableViewDataSourceRow

  - *Need to be subclassed*
  - `objectClass`
    - What is the class if the `id` object stored by the row.

### TableViewCell

  - *Need to be subclassed*

