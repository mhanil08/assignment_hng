import pymysql.cursors 
from app import app
from db import mysql
from flask import jsonify
from flask import flash, session, redirect, request


@app.route('/adduser', methods=['POST'])
def add_user():
	conn = None
	cursor = None
	try:
		_json = request.json
		_user_login = _json['user_login']
		_current_password = _json['current_password']
		_user_mobile = _json['user_mobile']
		_user_status=_json['user_status']
		# validate the received values
		if _user_login and _current_password and _user_mobile and _user_status and request.method == 'POST':		
			# save edits
			sql = "INSERT INTO user(user_login, current_password, user_mobile, user_status, created_stamp, updated_stamp) VALUES(%s, %s, %s,%s,)"
			data = (_user_login, _current_password, _current_password,_user_status,)
			conn = mysql.connect()
			cursor = conn.cursor()
			cursor.execute(sql, data)
			conn.commit()
			resp = jsonify('User added successfully!')
			resp.status_code = 200
			return resp
		else:
			return not_found()
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()


@app.route('/products', methods=['GET'])
def products():
	conn = None
	cursor = None
	try:
		conn = mysql.connect()
		cursor = conn.cursor(pymysql.cursors.DictCursor)
		cursor.execute("SELECT  PRODUCT_ID product_id, CATEGORY_ID category_id, CATEGORY_NAME category_name, PARENT_CATEGORY_LINK parent_category_link, BRAND_ID brand_id, \
		BRAND_NAME brand_name, PRODUCT_TITLE product_title, CREATED_STAMP created_stamp, LAST_UPDATED_STAMP last_updated_stamp, MRP_PRICE mrp_price, LIST_PRICE list_price FROM hng_product_master")
		rows = cursor.fetchall()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		print("No products available",e)
	finally:
		cursor.close() 
		conn.close()

@app.route('/baskets', methods=['GET'])
def baskets():
	conn = None
	cursor = None
	try:
		conn = mysql.connect()
		cursor = conn.cursor(pymysql.cursors.DictCursor)
		cursor.execute("SELECT  ID id, USER_ID user_id, NO_OF_ITEMS no_of_items, GRAND_TOTAL grand_total, DELIVERY_CHARGE delivery_charge, APPLIED_COUPON_CODE applied_coupon_code, \
			 COUPON_AMOUNT coupon_amount, LAST_UPDATED_STAMP last_updated_stamp, CREATED_STAMP created_stamp FROM hng_basket")
		rows = cursor.fetchall()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		print("None!!!",e)
	finally:
		cursor.close() 
		conn.close()

@app.route('/basket/<int:id>', methods=['GET'])
def basket(id):
	conn = None
	cursor = None
	try:
		conn = mysql.connect()
		cursor = conn.cursor(pymysql.cursors.DictCursor)
		cursor.execute("SELECT  ID id, USER_ID user_id, NO_OF_ITEMS no_of_items, GRAND_TOTAL grand_total, DELIVERY_CHARGE delivery_charge, APPLIED_COUPON_CODE applied_coupon_code, \
			 COUPON_AMOUNT coupon_amount, LAST_UPDATED_STAMP last_updated_stamp, CREATED_STAMP created_stamp FROM hng_basket where id=%s", id)
		rows = cursor.fetchall()
		resp = jsonify(rows)
		resp.status_code = 200
		return resp
	except Exception as e:
		print("Basket not found!",e)
	finally:
		cursor.close() 
		conn.close()


@app.route('/additem/<int:id>', methods=['POST'])
def add_item_to_basket(id):
	cursor = None
	try:
		_quantity = int('quantity')
		_product_id = 'product_id'
		# validate the received values
		if _quantity and _product_id and request.method == 'POST':
			conn = mysql.connect()
			cursor = conn.cursor(pymysql.cursors.DictCursor)
			cursor.execute("SELECT * FROM hng_product_master WHERE product_id=%s", _product_id)
			row = cursor.fetchone()
			
			itemArray = { row['product_id'] : {'product_id' : row['product_id'], 'product_title' : row['product_title'], 'quantity' : _quantity, 'list_price' : row['list_price'], 'mrp_price' : row['mrp_price'], 'total_price': _quantity * row['list_price']}}
			
			all_total_price = 0
			all_total_quantity = 0
			
			session.modified = True
			if 'item_basket' in session:
				if row['product_id'] in session['item_basket']:
					for key, value in session['item_basket'].items():
						if row['product_id'] == key:
							#session.modified = True
							#if session['cart_item'][key]['quantity'] is not None:
							#	session['cart_item'][key]['quantity'] = 0
							old_quantity = session['item_basket'][key]['quantity']
							total_quantity = old_quantity + _quantity
							session['item_basket'][key]['quantity'] = total_quantity
							session['item_basket'][key]['total_price'] = total_quantity * row['price']
				else:
					session['item_basket'] = array_merge(session['cart_item'], itemArray)

				for key, value in session['item_basket'].items():
					individual_quantity = int(session['item_basket'][key]['item_basket'])
					individual_price = float(session['item_basket'][key]['total_price'])
					all_total_quantity = all_total_quantity + individual_quantity
					all_total_price = all_total_price + individual_price
			else:
				session['item_basket'] = itemArray
				all_total_quantity = all_total_quantity + _quantity
				all_total_price = all_total_price + _quantity * row['price']
			
			session['all_total_quantity'] = all_total_quantity
			session['all_total_price'] = all_total_price
			
			return ('/products')
		else:			
			return 'Error while adding item to cart'
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()

def array_merge( first_array , second_array ):
	if isinstance( first_array , list ) and isinstance( second_array , list ):
		return first_array + second_array
	elif isinstance( first_array , dict ) and isinstance( second_array , dict ):
		return dict( list( first_array.items() ) + list( second_array.items() ) )
	elif isinstance( first_array , set ) and isinstance( second_array , set ):
		return first_array.union( second_array )
	return False


@app.route('/delete/<string:id>', methods=['DELETE'])
def delete_user(id):
	conn = None
	cursor = None
	try:
		conn = mysql.connect()
		cursor = conn.cursor()
		cursor.execute("DELETE FROM hng_basket_item WHERE PRODUCT_ID=%s", (id,))
		conn.commit()
		resp = jsonify('User deleted successfully!')
		resp.status_code = 200
		return resp
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()


@app.route('/update', methods=['PUT'])
def update_user():
	conn = None
	cursor = None
	try:
		_json = request.json
		_id = _json['id']
		_name = _json['name']
		_age = _json['age']
		_occupation = _json['occupation']		
		# validate the received values
		if _name and _age and _occupation and _id and request.method == 'PUT':
			
			
			# save edits
			sql = "UPDATE user SET name=%s, age=%s, occupation=%s WHERE userid=%s"
			data = (_name, _age, _occupation, _id,)
			conn = mysql.connect()
			cursor = conn.cursor()
			cursor.execute(sql, data)
			conn.commit()
			resp = jsonify('User updated successfully!')
			resp.status_code = 200
			return resp
		else:
			return not_found()
	except Exception as e:
		print(e)
	finally:
		cursor.close() 
		conn.close()
		
		
@app.errorhandler(404)
def not_found(error=None):
    message = {
        'status': 404,
        'message': 'Not Found: ' + request.url,
    }
    resp = jsonify(message)
    resp.status_code = 404

    return resp


if __name__ == "__main__":
	app.debug = True
    
	app.run(port=5001)
