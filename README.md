# TablePattern

[![](https://img.shields.io/badge/contact-@thematerik-blue.svg?style=flat-square)](http://twitter.com/thematerik)
[![](https://img.shields.io/cocoapods/v/TablePattern.svg?style=flat-square)](https://cocoapods.org/pods/TablePattern)
![](https://img.shields.io/cocoapods/p/TablePattern.svg?style=flat-square)
![](https://img.shields.io/cocoapods/l/TablePattern.svg?style=flat-square)

## Install

```
pod 'TablePattern'
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
  - `- createSectionInSection:`
    - Create an instance of a subclassed `TableViewSection`, given the data
      that has been loaded in either `loadData` method, for that specific section.

### TableViewSection

  - *Need to be subclassed*
  - `objectClass`
    - What is the class if the `id` object stored by the section.
  - `- numberOfRows`
    - Return the number of rows that this section should contain.
  - `- createRowAtRow:`
    - Create an instance of a subclassed `TableViewRow`, given the
      object stored by the section, for that specific row.

### TableViewRow

  - *Need to be subclassed*
  - `objectClass`
    - What is the class if the `id` object stored by the row.

### TableViewCell

  - *Need to be subclassed*

