package common

// Cursor-Based Pagination support
//
// - How it works: Use the cursor to specify the starting point
// - Advantages: Higher performance, especially with large datasets
// - Disadvantages: More complicated, can't jump directly to a specific page
//
// string FakeCursor
// 	- Is the value of the current pointer
// 	- When the client sends a request to get the data of the next page, this value will be used as the starting point.
//
// string NextCursor
// 	- It is a pointer value to the next page, which helps the client know what to pass to the FakeCursor in the next request.
// 	- After querying the data, the backend will calculate the NextCursor value and return it to the client.
// 	- If the NextCursor is empty, it means the last page has been reached.
type Paging struct {
	Page       int    `json:"page" form:"page"`
	Limit      int    `json:"limit" form:"limit"`
	Total      int64  `json:"total" form:"-"`
	FakeCursor string `json:"cursor" form:"cursor"` 
	NextCursor string `json:"next_cursor"`
}

func (p *Paging) Process() {
	if p.Page < 1 {
		p.Page = 1
	}

	if p.Limit <= 0 {
		p.Limit = 10
	}

	if p.Limit >= 200 {
		p.Limit = 200
	}
}
